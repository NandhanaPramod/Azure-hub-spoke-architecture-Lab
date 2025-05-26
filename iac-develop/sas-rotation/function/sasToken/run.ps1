param($eventGridEvent, $TriggerMetadata)

function RegenerateSASToken($storageAccountName, $validityPeriodDays, $resourceGroup){
    Write-Host "Regenerating SAS token. Storage Account: $StorageAccountName Validity(in Days): $validityPeriodDays"   
    $storageAccountKey = (Get-AzStorageAccountKey -ResourceGroupName $resourceGroup -Name $storageAccountName).value[0]
    $storageAccountContext = (New-AzStorageContext -StorageAccountName $storageAccountName -StorageAccountKey $storageAccountKey)
    $newSASToken = (New-AzStorageAccountSASToken -Context $storageAccountContext -Service "Blob" -ResourceType "Object" -Permission "r" -ExpiryTime (Get-Date).AddDays($validityPeriodDays) -StartTime (Get-Date) -Protocol "HttpsOnly")
    return $newSASToken
}

function AddSecretToKeyVault($keyVaultName,$secretName,$secretValue,$expiryDate,$tags){
    
    return (Set-AzKeyVaultSecret -VaultName $keyVaultName -Name $secretName -SecretValue $secretValue -Tag $tags -Expires $expiryDate).Version

}

function RoatateSecret($keyVaultName,$secretName,$secretVersion){
    #Retrieve Secret
    $secret = (Get-AzKeyVaultSecret -VaultName $keyVaultName -Name $secretName)
    Write-Host "Secret Retrieved"
    
    If($secret.Version -ne $secretVersion){
        #if current version is different than one retrived in event
        Write-Host "Secret version is already rotated"
        return 
    }

    #Retrieve Secret Info
    $validityPeriodDays = $secret.Tags["ValidityPeriodDays"]
    $mediaStorageAccount=  $secret.Tags["MediaStorageAccountName"]
    $resourceGroup =  $secret.Tags["ResourceGroup"]

    
    Write-Host "Secret Info Retrieved"
    Write-Host "Validity Period: $validityPeriodDays"
    Write-Host "Media Storage Account: $mediaStorageAccount"
    Write-Host "Resource Group: $resourceGroup"

    #Regenerate new SAS token
    $newSASToken = (RegenerateSASToken $mediaStorageAccount $validityPeriodDays $resourceGroup)
    $secretValue = ConvertTo-SecureString "$newSASToken" -AsPlainText -Force
    Write-Host "SAS token regenerated."

    #Add new secret to Key Vault
    $newSecretVersionTags = @{}
    $newSecretVersionTags.ValidityPeriodDays = $validityPeriodDays
    $newSecretVersionTags.MediaStorageAccountName=$mediaStorageAccount
    $newSecretVersionTags.ResourceGroup = $resourceGroup

    $expiryDate = (Get-Date).AddDays([int]$validityPeriodDays-1).ToUniversalTime()
    $newVersion = (AddSecretToKeyVault $keyVaultName $secretName $secretValue $expiryDate $newSecretVersionTags)

    Write-Host "New SAS token added to Key Vault. Secret Name: $secretName, Version: $newVersion"
    return
}

$ErrorActionPreference = "Stop"
# Make sure to pass hashtables to Out-String so they're logged correctly
$eventGridEvent | ConvertTo-Json | Write-Host

$secretName = $eventGridEvent.subject
$secretVersion = $eventGridEvent.data.Version
$keyVaultName = $eventGridEvent.data.VaultName
$subscription = $eventGridEvent.topic.split("/")[2]

Write-Host "Key Vault Name: $keyVaultName"
Write-Host "Secret Name: $secretName"
Write-Host "Subscription: $subscription"

#Set Context
Set-AzContext -Subscription $subscription

#Rotate secret
Write-Host "Rotation started."
RoatateSecret $keyVaultName $secretName $secretVersion
Write-Host "Secret Rotated Successfully. KeyVault: $keyVaultName, Secret: $secretName"