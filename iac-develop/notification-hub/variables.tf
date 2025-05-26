variable "basename" {
  description = "Prefix used for all resources names"
  type        = string
}

variable "environment" {
  description = "Prefix used for environment name"
  type        = string
}

variable "location" {
  type        = string
  description = "Location where Notification Hub will be running on"
}

variable "google_api_key" {
  type        = string
  description = "Push notification Google api key"
}

variable "application_mode" {
  type        = string
  description = "The Application Mode which defines which server the APNS Messages should be sent to. Possible values are Production and Sandbox."
}

variable "bundle_id" {
  type        = string
  description = "The Bundle ID of the iOS/macOS application to send push notifications for, such as com.hashicorp.example."
}

variable "key_id" {
  type        = string
  description = "The Apple Push Notifications Service (APNS) Key."
}

variable "team_id" {
  type        = string
  description = "The ID of the team the Token."
}

variable "token" {
  type        = string
  description = "The Push Token associated with the Apple Developer Account. This is the contents of the key downloaded from the Apple Developer Portal between the -----BEGIN PRIVATE KEY----- and -----END PRIVATE KEY----- blocks."
}

variable "default_tags" {
  type        = map(string)
  description = "Common tags for resources"
}