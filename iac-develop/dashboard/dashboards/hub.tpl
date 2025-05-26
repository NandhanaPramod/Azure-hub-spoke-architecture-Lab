{
    "lenses": {
        "0": {
            "order": 0,
            "parts": {
                "0": {
                    "position": {
                        "x": 0,
                        "y": 0,
                        "colSpan": 6,
                        "rowSpan": 4
                    },
                    "metadata": {
                        "inputs": [
                            {
                                "name": "resourceTypeMode",
                                "isOptional": true
                            },
                            {
                                "name": "ComponentId",
                                "isOptional": true
                            },
                            {
                                "name": "Scope",
                                "value": {
                                    "resourceIds": [
                                        "${application_gateway_resource_id}"
                                    ]
                                },
                                "isOptional": true
                            },
                            {
                                "name": "PartId",
                                "value": "11f1adfb-78e3-42cb-b743-12c0e2155ad9",
                                "isOptional": true
                            },
                            {
                                "name": "Version",
                                "value": "2.0",
                                "isOptional": true
                            },
                            {
                                "name": "TimeRange",
                                "value": "P1D",
                                "isOptional": true
                            },
                            {
                                "name": "DashboardId",
                                "isOptional": true
                            },
                            {
                                "name": "DraftRequestParameters",
                                "value": {
                                    "scope": "hierarchy"
                                },
                                "isOptional": true
                            },
                            {
                                "name": "Query",
                                "value": "AzureDiagnostics\n| where ResourceType == \"APPLICATIONGATEWAYS\" and OperationName == \"ApplicationGatewayAccess\"\n| project-rename RequestURI = requestUri_s, HostName = originalHost_s\n| summarize TotalCount = count() by RequestURI, HostName\n| top 10 by TotalCount\n",
                                "isOptional": true
                            },
                            {
                                "name": "ControlType",
                                "value": "AnalyticsGrid",
                                "isOptional": true
                            },
                            {
                                "name": "SpecificChart",
                                "isOptional": true
                            },
                            {
                                "name": "PartTitle",
                                "value": "Analytics",
                                "isOptional": true
                            },
                            {
                                "name": "PartSubTitle",
                                "value": "${application_gateway_name}",
                                "isOptional": true
                            },
                            {
                                "name": "Dimensions",
                                "isOptional": true
                            },
                            {
                                "name": "LegendOptions",
                                "isOptional": true
                            },
                            {
                                "name": "IsQueryContainTimeRange",
                                "value": false,
                                "isOptional": true
                            }
                        ],
                        "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
                        "settings": {
                            "content": {
                                "PartTitle": "Top 10 request URI by count"
                            }
                        }
                    }
                },
                "1": {
                    "position": {
                        "x": 6,
                        "y": 0,
                        "colSpan": 6,
                        "rowSpan": 4
                    },
                    "metadata": {
                        "inputs": [
                            {
                                "name": "sharedTimeRange",
                                "isOptional": true
                            },
                            {
                                "name": "options",
                                "value": {
                                    "chart": {
                                        "grouping": {
                                            "dimension": "BackendPool",
                                            "sort": 2,
                                            "top": 10
                                        },
                                        "metrics": [
                                            {
                                                "aggregationType": 4,
                                                "metricVisualization": {
                                                    "displayName": "Backend Connect Time"
                                                },
                                                "name": "BackendConnectTime",
                                                "namespace": "microsoft.network/applicationgateways",
                                                "resourceMetadata": {
                                                    "id": "${application_gateway_resource_id}"
                                                }
                                            }
                                        ],
                                        "timespan": {
                                            "grain": 1,
                                            "relative": {
                                                "duration": 86400000
                                            },
                                            "showUTCTime": false
                                        },
                                        "title": "Avg Backend Connect Time for oss-app-gw-bt by Backend Pool",
                                        "titleKind": 1,
                                        "visualization": {
                                            "axisVisualization": {
                                                "x": {
                                                    "axisType": 2,
                                                    "isVisible": true
                                                },
                                                "y": {
                                                    "axisType": 1,
                                                    "isVisible": true
                                                }
                                            },
                                            "chartType": 2,
                                            "legendVisualization": {
                                                "hideSubtitle": false,
                                                "isVisible": true,
                                                "position": 2
                                            }
                                        }
                                    }
                                },
                                "isOptional": true
                            }
                        ],
                        "type": "Extension/HubsExtension/PartType/MonitorChartPart",
                        "settings": {
                            "content": {
                                "options": {
                                    "chart": {
                                        "grouping": {
                                            "dimension": "BackendPool",
                                            "sort": 2,
                                            "top": 10
                                        },
                                        "metrics": [
                                            {
                                                "aggregationType": 4,
                                                "metricVisualization": {
                                                    "displayName": "Backend Connect Time"
                                                },
                                                "name": "BackendConnectTime",
                                                "namespace": "microsoft.network/applicationgateways",
                                                "resourceMetadata": {
                                                    "id": "${application_gateway_resource_id}"
                                                }
                                            }
                                        ],
                                        "title": "Avg Backend Connect Time by BackendPool",
                                        "titleKind": 2,
                                        "visualization": {
                                            "axisVisualization": {
                                                "x": {
                                                    "axisType": 2,
                                                    "isVisible": true
                                                },
                                                "y": {
                                                    "axisType": 1,
                                                    "isVisible": true
                                                }
                                            },
                                            "chartType": 2,
                                            "disablePinning": true,
                                            "legendVisualization": {
                                                "hideSubtitle": false,
                                                "isVisible": true,
                                                "position": 2
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                },
                "2": {
                    "position": {
                        "x": 12,
                        "y": 0,
                        "colSpan": 6,
                        "rowSpan": 4
                    },
                    "metadata": {
                        "inputs": [
                            {
                                "name": "sharedTimeRange",
                                "isOptional": true
                            },
                            {
                                "name": "options",
                                "value": {
                                    "chart": {
                                        "metrics": [
                                            {
                                                "aggregationType": 1,
                                                "metricVisualization": {
                                                    "displayName": "Current Connections"
                                                },
                                                "name": "CurrentConnections",
                                                "namespace": "microsoft.network/applicationgateways",
                                                "resourceMetadata": {
                                                    "id": "${application_gateway_resource_id}"
                                                }
                                            }
                                        ],
                                        "timespan": {
                                            "grain": 1,
                                            "relative": {
                                                "duration": 86400000
                                            },
                                            "showUTCTime": false
                                        },
                                        "title": "Current Connections by BackendSettingsPool",
                                        "titleKind": 2,
                                        "visualization": {
                                            "axisVisualization": {
                                                "x": {
                                                    "axisType": 2,
                                                    "isVisible": true
                                                },
                                                "y": {
                                                    "axisType": 1,
                                                    "isVisible": true
                                                }
                                            },
                                            "chartType": 2,
                                            "legendVisualization": {
                                                "hideSubtitle": false,
                                                "isVisible": true,
                                                "position": 2
                                            }
                                        }
                                    }
                                },
                                "isOptional": true
                            }
                        ],
                        "type": "Extension/HubsExtension/PartType/MonitorChartPart",
                        "settings": {
                            "content": {
                                "options": {
                                    "chart": {
                                        "metrics": [
                                            {
                                                "aggregationType": 1,
                                                "metricVisualization": {
                                                    "displayName": "Current Connections"
                                                },
                                                "name": "CurrentConnections",
                                                "namespace": "microsoft.network/applicationgateways",
                                                "resourceMetadata": {
                                                    "id": "${application_gateway_resource_id}"
                                                }
                                            }
                                        ],
                                        "title": "Current Connections by BackendSettingsPool",
                                        "titleKind": 2,
                                        "visualization": {
                                            "axisVisualization": {
                                                "x": {
                                                    "axisType": 2,
                                                    "isVisible": true
                                                },
                                                "y": {
                                                    "axisType": 1,
                                                    "isVisible": true
                                                }
                                            },
                                            "chartType": 2,
                                            "disablePinning": true,
                                            "legendVisualization": {
                                                "hideSubtitle": false,
                                                "isVisible": true,
                                                "position": 2
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                },
                "3": {
                    "position": {
                        "x": 0,
                        "y": 4,
                        "colSpan": 6,
                        "rowSpan": 4
                    },
                    "metadata": {
                        "inputs": [
                            {
                                "name": "sharedTimeRange",
                                "isOptional": true
                            },
                            {
                                "name": "options",
                                "value": {
                                    "chart": {
                                        "grouping": {
                                            "dimension": "HttpStatusGroup",
                                            "sort": 2,
                                            "top": 10
                                        },
                                        "metrics": [
                                            {
                                                "aggregationType": 1,
                                                "metricVisualization": {
                                                    "displayName": "Response Status"
                                                },
                                                "name": "ResponseStatus",
                                                "namespace": "microsoft.network/applicationgateways",
                                                "resourceMetadata": {
                                                    "id": "${application_gateway_resource_id}"
                                                }
                                            }
                                        ],
                                        "timespan": {
                                            "grain": 1,
                                            "relative": {
                                                "duration": 86400000
                                            },
                                            "showUTCTime": false
                                        },
                                        "title": "Response Status by HttpStatusGroup",
                                        "titleKind": 2,
                                        "visualization": {
                                            "axisVisualization": {
                                                "x": {
                                                    "axisType": 2,
                                                    "isVisible": true
                                                },
                                                "y": {
                                                    "axisType": 1,
                                                    "isVisible": true
                                                }
                                            },
                                            "chartType": 2,
                                            "legendVisualization": {
                                                "hideSubtitle": false,
                                                "isVisible": true,
                                                "position": 2
                                            }
                                        }
                                    }
                                },
                                "isOptional": true
                            }
                        ],
                        "type": "Extension/HubsExtension/PartType/MonitorChartPart",
                        "settings": {
                            "content": {
                                "options": {
                                    "chart": {
                                        "grouping": {
                                            "dimension": "HttpStatusGroup",
                                            "sort": 2,
                                            "top": 10
                                        },
                                        "metrics": [
                                            {
                                                "aggregationType": 1,
                                                "metricVisualization": {
                                                    "displayName": "Response Status"
                                                },
                                                "name": "ResponseStatus",
                                                "namespace": "microsoft.network/applicationgateways",
                                                "resourceMetadata": {
                                                    "id": "${application_gateway_resource_id}"
                                                }
                                            }
                                        ],
                                        "title": "Response Status by HttpStatusGroup",
                                        "titleKind": 2,
                                        "visualization": {
                                            "axisVisualization": {
                                                "x": {
                                                    "axisType": 2,
                                                    "isVisible": true
                                                },
                                                "y": {
                                                    "axisType": 1,
                                                    "isVisible": true
                                                }
                                            },
                                            "chartType": 2,
                                            "disablePinning": true,
                                            "legendVisualization": {
                                                "hideSubtitle": false,
                                                "isVisible": true,
                                                "position": 2
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                },
                "4": {
                    "position": {
                        "x": 6,
                        "y": 4,
                        "colSpan": 6,
                        "rowSpan": 4
                    },
                    "metadata": {
                        "inputs": [
                            {
                                "name": "sharedTimeRange",
                                "isOptional": true
                            },
                            {
                                "name": "options",
                                "value": {
                                    "chart": {
                                        "metrics": [
                                            {
                                                "aggregationType": 4,
                                                "metricVisualization": {
                                                    "displayName": "Throughput"
                                                },
                                                "name": "Throughput",
                                                "namespace": "microsoft.network/applicationgateways",
                                                "resourceMetadata": {
                                                    "id": "${application_gateway_resource_id}"
                                                }
                                            }
                                        ],
                                        "timespan": {
                                            "grain": 1,
                                            "relative": {
                                                "duration": 86400000
                                            },
                                            "showUTCTime": false
                                        },
                                        "title": "Application Gateway Throughput",
                                        "titleKind": 2,
                                        "visualization": {
                                            "axisVisualization": {
                                                "x": {
                                                    "axisType": 2,
                                                    "isVisible": true
                                                },
                                                "y": {
                                                    "axisType": 1,
                                                    "isVisible": true
                                                }
                                            },
                                            "chartType": 2,
                                            "legendVisualization": {
                                                "hideSubtitle": false,
                                                "isVisible": true,
                                                "position": 2
                                            }
                                        }
                                    }
                                },
                                "isOptional": true
                            }
                        ],
                        "type": "Extension/HubsExtension/PartType/MonitorChartPart",
                        "settings": {
                            "content": {
                                "options": {
                                    "chart": {
                                        "metrics": [
                                            {
                                                "aggregationType": 4,
                                                "metricVisualization": {
                                                    "displayName": "Throughput"
                                                },
                                                "name": "Throughput",
                                                "namespace": "microsoft.network/applicationgateways",
                                                "resourceMetadata": {
                                                    "id": "${application_gateway_resource_id}"
                                                }
                                            }
                                        ],
                                        "title": "Application Gateway Throughput",
                                        "titleKind": 2,
                                        "visualization": {
                                            "axisVisualization": {
                                                "x": {
                                                    "axisType": 2,
                                                    "isVisible": true
                                                },
                                                "y": {
                                                    "axisType": 1,
                                                    "isVisible": true
                                                }
                                            },
                                            "chartType": 2,
                                            "disablePinning": true,
                                            "legendVisualization": {
                                                "hideSubtitle": false,
                                                "isVisible": true,
                                                "position": 2
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                },
                "5": {
                    "position": {
                        "x": 12,
                        "y": 4,
                        "colSpan": 6,
                        "rowSpan": 4
                    },
                    "metadata": {
                        "inputs": [
                            {
                                "name": "sharedTimeRange",
                                "isOptional": true
                            },
                            {
                                "name": "options",
                                "value": {
                                    "chart": {
                                        "grouping": {
                                            "dimension": "Action",
                                            "sort": 2,
                                            "top": 10
                                        },
                                        "metrics": [
                                            {
                                                "aggregationType": 1,
                                                "metricVisualization": {
                                                    "displayName": "WAF Bot Protection Matches"
                                                },
                                                "name": "AzwafBotProtection",
                                                "namespace": "microsoft.network/applicationgateways",
                                                "resourceMetadata": {
                                                    "id": "${application_gateway_resource_id}"
                                                }
                                            }
                                        ],
                                        "timespan": {
                                            "grain": 1,
                                            "relative": {
                                                "duration": 86400000
                                            },
                                            "showUTCTime": false
                                        },
                                        "title": "WAF Bot Protection Matches by Action",
                                        "titleKind": 2,
                                        "visualization": {
                                            "axisVisualization": {
                                                "x": {
                                                    "axisType": 2,
                                                    "isVisible": true
                                                },
                                                "y": {
                                                    "axisType": 1,
                                                    "isVisible": true
                                                }
                                            },
                                            "chartType": 2,
                                            "legendVisualization": {
                                                "hideSubtitle": false,
                                                "isVisible": true,
                                                "position": 2
                                            }
                                        }
                                    }
                                },
                                "isOptional": true
                            }
                        ],
                        "type": "Extension/HubsExtension/PartType/MonitorChartPart",
                        "settings": {
                            "content": {
                                "options": {
                                    "chart": {
                                        "grouping": {
                                            "dimension": "Action",
                                            "sort": 2,
                                            "top": 10
                                        },
                                        "metrics": [
                                            {
                                                "aggregationType": 1,
                                                "metricVisualization": {
                                                    "displayName": "WAF Bot Protection Matches"
                                                },
                                                "name": "AzwafBotProtection",
                                                "namespace": "microsoft.network/applicationgateways",
                                                "resourceMetadata": {
                                                    "id": "${application_gateway_resource_id}"
                                                }
                                            }
                                        ],
                                        "title": "WAF Bot Protection Matches by Action",
                                        "titleKind": 2,
                                        "visualization": {
                                            "axisVisualization": {
                                                "x": {
                                                    "axisType": 2,
                                                    "isVisible": true
                                                },
                                                "y": {
                                                    "axisType": 1,
                                                    "isVisible": true
                                                }
                                            },
                                            "chartType": 2,
                                            "disablePinning": true,
                                            "legendVisualization": {
                                                "hideSubtitle": false,
                                                "isVisible": true,
                                                "position": 2
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                },
                "6": {
                    "position": {
                        "x": 0,
                        "y": 8,
                        "colSpan": 6,
                        "rowSpan": 4
                    },
                    "metadata": {
                        "inputs": [
                            {
                                "name": "sharedTimeRange",
                                "isOptional": true
                            },
                            {
                                "name": "options",
                                "value": {
                                    "chart": {
                                        "grouping": {
                                            "dimension": "Action",
                                            "sort": 2,
                                            "top": 10
                                        },
                                        "metrics": [
                                            {
                                                "aggregationType": 1,
                                                "metricVisualization": {
                                                    "displayName": "WAF Custom Rule Matches"
                                                },
                                                "name": "AzwafCustomRule",
                                                "namespace": "microsoft.network/applicationgateways",
                                                "resourceMetadata": {
                                                    "id": "${application_gateway_resource_id}"
                                                }
                                            }
                                        ],
                                        "timespan": {
                                            "grain": 1,
                                            "relative": {
                                                "duration": 86400000
                                            },
                                            "showUTCTime": false
                                        },
                                        "title": "WAF Custom Rule Matches by Action",
                                        "titleKind": 2,
                                        "visualization": {
                                            "axisVisualization": {
                                                "x": {
                                                    "axisType": 2,
                                                    "isVisible": true
                                                },
                                                "y": {
                                                    "axisType": 1,
                                                    "isVisible": true
                                                }
                                            },
                                            "chartType": 2,
                                            "legendVisualization": {
                                                "hideSubtitle": false,
                                                "isVisible": true,
                                                "position": 2
                                            }
                                        }
                                    }
                                },
                                "isOptional": true
                            }
                        ],
                        "type": "Extension/HubsExtension/PartType/MonitorChartPart",
                        "settings": {
                            "content": {
                                "options": {
                                    "chart": {
                                        "grouping": {
                                            "dimension": "Action",
                                            "sort": 2,
                                            "top": 10
                                        },
                                        "metrics": [
                                            {
                                                "aggregationType": 1,
                                                "metricVisualization": {
                                                    "displayName": "WAF Custom Rule Matches"
                                                },
                                                "name": "AzwafCustomRule",
                                                "namespace": "microsoft.network/applicationgateways",
                                                "resourceMetadata": {
                                                    "id": "${application_gateway_resource_id}"
                                                }
                                            }
                                        ],
                                        "title": "WAF Custom Rule Matches by Action",
                                        "titleKind": 2,
                                        "visualization": {
                                            "axisVisualization": {
                                                "x": {
                                                    "axisType": 2,
                                                    "isVisible": true
                                                },
                                                "y": {
                                                    "axisType": 1,
                                                    "isVisible": true
                                                }
                                            },
                                            "chartType": 2,
                                            "disablePinning": true,
                                            "legendVisualization": {
                                                "hideSubtitle": false,
                                                "isVisible": true,
                                                "position": 2
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                },
                "7": {
                    "position": {
                        "x": 6,
                        "y": 8,
                        "colSpan": 6,
                        "rowSpan": 4
                    },
                    "metadata": {
                        "inputs": [
                            {
                                "name": "sharedTimeRange",
                                "isOptional": true
                            },
                            {
                                "name": "options",
                                "value": {
                                    "chart": {
                                        "grouping": {
                                            "dimension": "RuleGroupID",
                                            "sort": 2,
                                            "top": 10
                                        },
                                        "metrics": [
                                            {
                                                "aggregationType": 1,
                                                "metricVisualization": {
                                                    "displayName": "WAF Managed Rule Matches"
                                                },
                                                "name": "AzwafSecRule",
                                                "namespace": "microsoft.network/applicationgateways",
                                                "resourceMetadata": {
                                                    "id": "${application_gateway_resource_id}"
                                                }
                                            }
                                        ],
                                        "timespan": {
                                            "grain": 1,
                                            "relative": {
                                                "duration": 86400000
                                            },
                                            "showUTCTime": false
                                        },
                                        "title": "WAF Managed Rule Matches by RuleGroup",
                                        "titleKind": 2,
                                        "visualization": {
                                            "axisVisualization": {
                                                "x": {
                                                    "axisType": 2,
                                                    "isVisible": true
                                                },
                                                "y": {
                                                    "axisType": 1,
                                                    "isVisible": true
                                                }
                                            },
                                            "chartType": 2,
                                            "legendVisualization": {
                                                "hideSubtitle": false,
                                                "isVisible": true,
                                                "position": 2
                                            }
                                        }
                                    }
                                },
                                "isOptional": true
                            }
                        ],
                        "type": "Extension/HubsExtension/PartType/MonitorChartPart",
                        "settings": {
                            "content": {
                                "options": {
                                    "chart": {
                                        "grouping": {
                                            "dimension": "RuleGroupID",
                                            "sort": 2,
                                            "top": 10
                                        },
                                        "metrics": [
                                            {
                                                "aggregationType": 1,
                                                "metricVisualization": {
                                                    "displayName": "WAF Managed Rule Matches"
                                                },
                                                "name": "AzwafSecRule",
                                                "namespace": "microsoft.network/applicationgateways",
                                                "resourceMetadata": {
                                                    "id": "${application_gateway_resource_id}"
                                                }
                                            }
                                        ],
                                        "title": "WAF Managed Rule Matches by RuleGroup",
                                        "titleKind": 2,
                                        "visualization": {
                                            "axisVisualization": {
                                                "x": {
                                                    "axisType": 2,
                                                    "isVisible": true
                                                },
                                                "y": {
                                                    "axisType": 1,
                                                    "isVisible": true
                                                }
                                            },
                                            "chartType": 2,
                                            "disablePinning": true,
                                            "legendVisualization": {
                                                "hideSubtitle": false,
                                                "isVisible": true,
                                                "position": 2
                                            }
                                        }
                                    }
                                }
                            }
                        },
                        "filters": {
                            "MsPortalFx_TimeRange": {
                                "model": {
                                    "format": "local",
                                    "granularity": "auto",
                                    "relative": "1440m"
                                }
                            }
                        }
                    }
                },
                "8": {
                    "position": {
                        "x": 12,
                        "y": 8,
                        "colSpan": 6,
                        "rowSpan": 4
                    },
                    "metadata": {
                        "inputs": [
                            {
                                "name": "sharedTimeRange",
                                "isOptional": true
                            },
                            {
                                "name": "options",
                                "value": {
                                    "chart": {
                                        "grouping": {
                                            "dimension": "Action",
                                            "sort": 2,
                                            "top": 10
                                        },
                                        "metrics": [
                                            {
                                                "aggregationType": 1,
                                                "metricVisualization": {
                                                    "displayName": "WAF Total Requests"
                                                },
                                                "name": "AzwafTotalRequests",
                                                "namespace": "microsoft.network/applicationgateways",
                                                "resourceMetadata": {
                                                    "id": "${application_gateway_resource_id}"
                                                }
                                            }
                                        ],
                                        "timespan": {
                                            "grain": 1,
                                            "relative": {
                                                "duration": 86400000
                                            },
                                            "showUTCTime": false
                                        },
                                        "title": "WAF Total Requests by Action",
                                        "titleKind": 2,
                                        "visualization": {
                                            "axisVisualization": {
                                                "x": {
                                                    "axisType": 2,
                                                    "isVisible": true
                                                },
                                                "y": {
                                                    "axisType": 1,
                                                    "isVisible": true
                                                }
                                            },
                                            "chartType": 2,
                                            "legendVisualization": {
                                                "hideSubtitle": false,
                                                "isVisible": true,
                                                "position": 2
                                            }
                                        }
                                    }
                                },
                                "isOptional": true
                            }
                        ],
                        "type": "Extension/HubsExtension/PartType/MonitorChartPart",
                        "settings": {
                            "content": {
                                "options": {
                                    "chart": {
                                        "grouping": {
                                            "dimension": "Action",
                                            "sort": 2,
                                            "top": 10
                                        },
                                        "metrics": [
                                            {
                                                "aggregationType": 1,
                                                "metricVisualization": {
                                                    "displayName": "WAF Total Requests"
                                                },
                                                "name": "AzwafTotalRequests",
                                                "namespace": "microsoft.network/applicationgateways",
                                                "resourceMetadata": {
                                                    "id": "${application_gateway_resource_id}"
                                                }
                                            }
                                        ],
                                        "title": "WAF Total Requests by Action",
                                        "titleKind": 2,
                                        "visualization": {
                                            "axisVisualization": {
                                                "x": {
                                                    "axisType": 2,
                                                    "isVisible": true
                                                },
                                                "y": {
                                                    "axisType": 1,
                                                    "isVisible": true
                                                }
                                            },
                                            "chartType": 2,
                                            "disablePinning": true,
                                            "legendVisualization": {
                                                "hideSubtitle": false,
                                                "isVisible": true,
                                                "position": 2
                                            }
                                        }
                                    }
                                }
                            }
                        },
                        "filters": {
                            "MsPortalFx_TimeRange": {
                                "model": {
                                    "format": "local",
                                    "granularity": "auto",
                                    "relative": "1440m"
                                }
                            }
                        }
                    }
                },
                "9": {
                    "position": {
                        "x": 0,
                        "y": 12,
                        "colSpan": 6,
                        "rowSpan": 4
                    },
                    "metadata": {
                        "inputs": [
                            {
                                "name": "resourceTypeMode",
                                "isOptional": true
                            },
                            {
                                "name": "ComponentId",
                                "isOptional": true
                            },
                            {
                                "name": "Scope",
                                "value": {
                                    "resourceIds": [
                                        "${application_gateway_resource_id}"
                                    ]
                                },
                                "isOptional": true
                            },
                            {
                                "name": "PartId",
                                "value": "04a2d890-8559-4c34-99d2-bd96210d29a1",
                                "isOptional": true
                            },
                            {
                                "name": "Version",
                                "value": "2.0",
                                "isOptional": true
                            },
                            {
                                "name": "TimeRange",
                                "value": "PT4H",
                                "isOptional": true
                            },
                            {
                                "name": "DashboardId",
                                "isOptional": true
                            },
                            {
                                "name": "DraftRequestParameters",
                                "value": {
                                    "scope": "hierarchy"
                                },
                                "isOptional": true
                            },
                            {
                                "name": "Query",
                                "value": "AzureDiagnostics\n| where ResourceType == \"APPLICATIONGATEWAYS\" and OperationName == \"ApplicationGatewayAccess\"\n| sort by timeTaken_d\n| project-rename URI = originalRequestUriWithArgs_s, Host = originalHost_s, DurationInSeconds = timeTaken_d\n| project TimeGenerated, Host, URI, DurationInSeconds\n| limit 10\n",
                                "isOptional": true
                            },
                            {
                                "name": "ControlType",
                                "value": "AnalyticsGrid",
                                "isOptional": true
                            },
                            {
                                "name": "SpecificChart",
                                "isOptional": true
                            },
                            {
                                "name": "PartTitle",
                                "value": "Analytics",
                                "isOptional": true
                            },
                            {
                                "name": "PartSubTitle",
                                "value": "oss-app-gw-bt",
                                "isOptional": true
                            },
                            {
                                "name": "Dimensions",
                                "isOptional": true
                            },
                            {
                                "name": "LegendOptions",
                                "isOptional": true
                            },
                            {
                                "name": "IsQueryContainTimeRange",
                                "value": false,
                                "isOptional": true
                            }
                        ],
                        "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
                        "settings": {
                            "content": {
                                "PartTitle": "Top 10 requests by duration"
                            }
                        }
                    }
                },
                "10": {
                    "position": {
                        "x": 6,
                        "y": 12,
                        "colSpan": 6,
                        "rowSpan": 4
                    },
                    "metadata": {
                        "inputs": [
                            {
                                "name": "resourceTypeMode",
                                "isOptional": true
                            },
                            {
                                "name": "ComponentId",
                                "isOptional": true
                            },
                            {
                                "name": "Scope",
                                "value": {
                                    "resourceIds": [
                                        "${application_gateway_resource_id}"
                                    ]
                                },
                                "isOptional": true
                            },
                            {
                                "name": "PartId",
                                "value": "107bc7c2-5948-43b2-b656-4de82277eded",
                                "isOptional": true
                            },
                            {
                                "name": "Version",
                                "value": "2.0",
                                "isOptional": true
                            },
                            {
                                "name": "TimeRange",
                                "value": "P1D",
                                "isOptional": true
                            },
                            {
                                "name": "DashboardId",
                                "isOptional": true
                            },
                            {
                                "name": "DraftRequestParameters",
                                "value": {
                                    "scope": "hierarchy"
                                },
                                "isOptional": true
                            },
                            {
                                "name": "Query",
                                "value": "AzureDiagnostics\n| where ResourceType == \"APPLICATIONGATEWAYS\" and OperationName == \"ApplicationGatewayAccess\" and httpStatus_d > 399\n| project-rename ResponseStatus = httpStatus_d, Host = originalHost_s, URI = originalRequestUriWithArgs_s\n| summarize TotalCount = count() by Host, URI, ResponseStatus\n| top 10 by TotalCount\n",
                                "isOptional": true
                            },
                            {
                                "name": "ControlType",
                                "value": "AnalyticsGrid",
                                "isOptional": true
                            },
                            {
                                "name": "SpecificChart",
                                "isOptional": true
                            },
                            {
                                "name": "PartTitle",
                                "value": "Analytics",
                                "isOptional": true
                            },
                            {
                                "name": "PartSubTitle",
                                "value": "oss-app-gw-bt",
                                "isOptional": true
                            },
                            {
                                "name": "Dimensions",
                                "isOptional": true
                            },
                            {
                                "name": "LegendOptions",
                                "isOptional": true
                            },
                            {
                                "name": "IsQueryContainTimeRange",
                                "value": false,
                                "isOptional": true
                            }
                        ],
                        "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
                        "settings": {
                            "content": {
                                "PartTitle": "Top 10 failed requests by count"
                            }
                        }
                    }
                },
                "11": {
                    "position": {
                        "x": 12,
                        "y": 12,
                        "colSpan": 6,
                        "rowSpan": 4
                    },
                    "metadata": {
                        "inputs": [
                            {
                                "name": "resourceTypeMode",
                                "isOptional": true
                            },
                            {
                                "name": "ComponentId",
                                "isOptional": true
                            },
                            {
                                "name": "Scope",
                                "value": {
                                    "resourceIds": [
                                        "${application_gateway_resource_id}"
                                    ]
                                },
                                "isOptional": true
                            },
                            {
                                "name": "PartId",
                                "value": "754eba26-e55a-435d-85a2-0e55e52caab2",
                                "isOptional": true
                            },
                            {
                                "name": "Version",
                                "value": "2.0",
                                "isOptional": true
                            },
                            {
                                "name": "TimeRange",
                                "value": "P1D",
                                "isOptional": true
                            },
                            {
                                "name": "DashboardId",
                                "isOptional": true
                            },
                            {
                                "name": "DraftRequestParameters",
                                "value": {
                                    "scope": "hierarchy"
                                },
                                "isOptional": true
                            },
                            {
                                "name": "Query",
                                "value": "AzureDiagnostics\n| where ResourceType == \"APPLICATIONGATEWAYS\" and OperationName == \"ApplicationGatewayAccess\"\n| project-rename UserAgent = userAgent_s\n| summarize TotalCount = count() by UserAgent\n| top 10 by TotalCount\n",
                                "isOptional": true
                            },
                            {
                                "name": "ControlType",
                                "value": "FrameControlChart",
                                "isOptional": true
                            },
                            {
                                "name": "SpecificChart",
                                "value": "StackedColumn",
                                "isOptional": true
                            },
                            {
                                "name": "PartTitle",
                                "value": "Analytics",
                                "isOptional": true
                            },
                            {
                                "name": "PartSubTitle",
                                "value": "oss-app-gw-bt",
                                "isOptional": true
                            },
                            {
                                "name": "Dimensions",
                                "value": {
                                    "aggregation": "Sum",
                                    "splitBy": [],
                                    "xAxis": {
                                        "name": "UserAgent",
                                        "type": "string"
                                    },
                                    "yAxis": [
                                        {
                                            "name": "TotalCount",
                                            "type": "long"
                                        }
                                    ]
                                },
                                "isOptional": true
                            },
                            {
                                "name": "LegendOptions",
                                "value": {
                                    "isEnabled": true,
                                    "position": "Bottom"
                                },
                                "isOptional": true
                            },
                            {
                                "name": "IsQueryContainTimeRange",
                                "value": false,
                                "isOptional": true
                            }
                        ],
                        "type": "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart",
                        "settings": {
                            "content": {
                                "PartTitle": "Top 10 user agents"
                            }
                        }
                    }
                }
            }
        }
    },
    "metadata": {
        "model": {
            "timeRange": {
                "value": {
                    "relative": {
                        "duration": 24,
                        "timeUnit": 1
                    }
                },
                "type": "MsPortalFx.Composition.Configuration.ValueTypes.TimeRange"
            },
            "filterLocale": {
                "value": "en-us"
            },
            "filters": {
                "value": {
                    "MsPortalFx_TimeRange": {
                        "model": {
                            "format": "utc",
                            "granularity": "auto",
                            "relative": "24h"
                        },
                        "displayCache": {
                            "name": "UTC Time",
                            "value": "Past 24 hours"
                        },
                        "filteredPartIds": [
                            "StartboardPart-LogsDashboardPart-915d9ec7-7ca1-41f2-999e-c84912e7c029",
                            "StartboardPart-MonitorChartPart-915d9ec7-7ca1-41f2-999e-c84912e7c02b",
                            "StartboardPart-MonitorChartPart-915d9ec7-7ca1-41f2-999e-c84912e7c02d",
                            "StartboardPart-MonitorChartPart-915d9ec7-7ca1-41f2-999e-c84912e7c02f",
                            "StartboardPart-MonitorChartPart-915d9ec7-7ca1-41f2-999e-c84912e7c031",
                            "StartboardPart-MonitorChartPart-915d9ec7-7ca1-41f2-999e-c84912e7c033",
                            "StartboardPart-MonitorChartPart-915d9ec7-7ca1-41f2-999e-c84912e7c035",
                            "StartboardPart-MonitorChartPart-915d9ec7-7ca1-41f2-999e-c84912e7c037",
                            "StartboardPart-MonitorChartPart-915d9ec7-7ca1-41f2-999e-c84912e7c039",
                            "StartboardPart-LogsDashboardPart-915d9ec7-7ca1-41f2-999e-c84912e7c03b",
                            "StartboardPart-LogsDashboardPart-915d9ec7-7ca1-41f2-999e-c84912e7c03d",
                            "StartboardPart-LogsDashboardPart-915d9ec7-7ca1-41f2-999e-c84912e7c03f"
                        ]
                    }
                }
            }
        }
    }
}