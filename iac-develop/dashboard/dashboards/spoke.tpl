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
                  "name": "sharedTimeRange",
                  "isOptional": true
                },
                {
                  "name": "options",
                  "value": {
                    "chart": {
                      "grouping": {
                        "dimension": "nodepool",
                        "sort": 2,
                        "top": 10
                      },
                      "metrics": [
                        {
                          "aggregationType": 4,
                          "metricVisualization": {
                            "displayName": "CPU Usage Percentage"
                          },
                          "name": "node_cpu_usage_percentage",
                          "namespace": "microsoft.containerservice/managedclusters",
                          "resourceMetadata": {
                            "id": "${aks_resource_id}"
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
                      "title": "Avg CPU Usage Percentage by Name of the nodepool",
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
                        "dimension": "nodepool",
                        "sort": 2,
                        "top": 10
                      },
                      "metrics": [
                        {
                          "aggregationType": 4,
                          "metricVisualization": {
                            "displayName": "CPU Usage Percentage"
                          },
                          "name": "node_cpu_usage_percentage",
                          "namespace": "microsoft.containerservice/managedclusters",
                          "resourceMetadata": {
                            "id": "${aks_resource_id}"
                          }
                        }
                      ],
                      "title": "Avg CPU by nodepool",
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
                        "dimension": "nodepool",
                        "sort": 2,
                        "top": 10
                      },
                      "metrics": [
                        {
                          "aggregationType": 4,
                          "metricVisualization": {
                            "displayName": "Memory RSS Percentage"
                          },
                          "name": "node_memory_rss_percentage",
                          "namespace": "microsoft.containerservice/managedclusters",
                          "resourceMetadata": {
                            "id": "${aks_resource_id}"
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
                      "title": "Avg Memory RSS Percentage by Name of the nodepool",
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
                        "dimension": "nodepool",
                        "sort": 2,
                        "top": 10
                      },
                      "metrics": [
                        {
                          "aggregationType": 4,
                          "metricVisualization": {
                            "displayName": "Memory RSS Percentage"
                          },
                          "name": "node_memory_rss_percentage",
                          "namespace": "microsoft.containerservice/managedclusters",
                          "resourceMetadata": {
                            "id": "${aks_resource_id}"
                          }
                        }
                      ],
                      "title": "Avg Memory RSS Percentage by nodepool",
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
                      "grouping": {
                        "dimension": "nodepool",
                        "sort": 2,
                        "top": 10
                      },
                      "metrics": [
                        {
                          "aggregationType": 4,
                          "metricVisualization": {
                            "displayName": "Memory Working Set Percentage"
                          },
                          "name": "node_memory_working_set_percentage",
                          "namespace": "microsoft.containerservice/managedclusters",
                          "resourceMetadata": {
                            "id": "${aks_resource_id}"
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
                      "title": "Avg Memory Working Set Percentage by Name of the nodepool",
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
                        "dimension": "nodepool",
                        "sort": 2,
                        "top": 10
                      },
                      "metrics": [
                        {
                          "aggregationType": 4,
                          "metricVisualization": {
                            "displayName": "Memory Working Set Percentage"
                          },
                          "name": "node_memory_working_set_percentage",
                          "namespace": "microsoft.containerservice/managedclusters",
                          "resourceMetadata": {
                            "id": "${aks_resource_id}"
                          }
                        }
                      ],
                      "title": "Avg Memory Working Set Percentage by nodepool",
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
                        "dimension": "node",
                        "sort": 2,
                        "top": 10
                      },
                      "metrics": [
                        {
                          "aggregationType": 4,
                          "metricVisualization": {
                            "displayName": "podCount"
                          },
                          "name": "podCount",
                          "namespace": "insights.container/pods",
                          "resourceMetadata": {
                            "id": "${aks_resource_id}"
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
                      "title": "Avg podCount by node",
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
                        "dimension": "node",
                        "sort": 2,
                        "top": 10
                      },
                      "metrics": [
                        {
                          "aggregationType": 4,
                          "metricVisualization": {
                            "displayName": "podCount"
                          },
                          "name": "podCount",
                          "namespace": "insights.container/pods",
                          "resourceMetadata": {
                            "id": "${aks_resource_id}"
                          }
                        }
                      ],
                      "title": "Avg podCount for by node",
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
                      "grouping": {
                        "dimension": "controllerName",
                        "sort": 2,
                        "top": 10
                      },
                      "metrics": [
                        {
                          "aggregationType": 4,
                          "metricVisualization": {
                            "displayName": "oomKilledContainerCount(preview)"
                          },
                          "name": "oomKilledContainerCount",
                          "namespace": "insights.container/pods",
                          "resourceMetadata": {
                            "id": "${aks_resource_id}"
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
                      "title": "Avg oomKilledContainerCount(preview) by controllerName",
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
                        "dimension": "controllerName",
                        "sort": 2,
                        "top": 10
                      },
                      "metrics": [
                        {
                          "aggregationType": 4,
                          "metricVisualization": {
                            "displayName": "oomKilledContainerCount(preview)"
                          },
                          "name": "oomKilledContainerCount",
                          "namespace": "insights.container/pods",
                          "resourceMetadata": {
                            "id": "${aks_resource_id}"
                          }
                        }
                      ],
                      "title": "Avg oomKilledContainerCount by controllerName",
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
                      "${aks_resource_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "8a16297b-e811-4bbe-8590-e0b619cc52d9",
                  "isOptional": true
                },
                {
                  "name": "Version",
                  "value": "2.0",
                  "isOptional": true
                },
                {
                  "name": "TimeRange",
                  "value": "PT1H",
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
                  "value": "let terminatingPods = (KubePodInventory| where PodStatus has \"Terminating\"| project PodUid);\nKubePodInventory\n| where PodUid !in~ (terminatingPods)\n| extend app = tostring(parse_json(PodLabel)[0][\"app\"])\n| distinct PodUid, app\n| summarize TotalCount = count() by app\n",
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
                  "value": "${aks_name}",
                  "isOptional": true
                },
                {
                  "name": "Dimensions",
                  "value": {
                    "aggregation": "Sum",
                    "splitBy": [],
                    "xAxis": {
                      "name": "app",
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
                  "Query": "let terminatingPods = (KubePodInventory| where PodStatus has \"Terminating\"| project PodUid);\nKubePodInventory\n| where PodUid !in~ (terminatingPods) and Namespace == \"${aks_namespace}\"\n| extend app = tostring(parse_json(PodLabel)[0][\"app\"])\n| distinct PodUid, app\n| summarize TotalCount = count() by app\n\n",
                  "PartTitle": "Number of pods by service",
                  "Dimensions": {
                    "xAxis": {
                      "name": "app",
                      "type": "string"
                    },
                    "yAxis": [
                      {
                        "name": "TotalCount",
                        "type": "long"
                      }
                    ],
                    "splitBy": [],
                    "aggregation": "Sum"
                  }
                }
              }
            }
          },
          "6": {
            "position": {
              "x": 0,
              "y": 8,
              "colSpan": 18,
              "rowSpan": 5
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
                      "${aks_resource_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "17d9ad02-4d6b-4dbc-b014-3f7273b4691b",
                  "isOptional": true
                },
                {
                  "name": "Version",
                  "value": "2.0",
                  "isOptional": true
                },
                {
                  "name": "TimeRange",
                  "value": "PT12H",
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
                  "value": "ContainerLog\n|join(\nKubePodInventory\n| extend podlabels = parse_json(PodLabel)\n| extend ApplicationName = tostring(podlabels[0][\"app\"])\n| distinct Computer, ContainerID, Namespace, ApplicationName\n)\non Computer, ContainerID\n| where LogEntrySource == \"stderr\"\n| summarize TotalCount = count() by LogEntry, Namespace, ApplicationName \n| top 10 by TotalCount\n",
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
                  "value": "${aks_name}",
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
                  "GridColumnsWidth": {
                    "LogEntry": "1126px"
                  },
                  "Query": "ContainerLog\n|join(\nKubePodInventory\n| where Namespace == \"${aks_namespace}\"\n| extend podlabels = parse_json(PodLabel)\n| extend ApplicationName = tostring(podlabels[0][\"app\"])\n| distinct Computer, ContainerID, ApplicationName\n)\non Computer, ContainerID\n| where LogEntrySource == \"stderr\"\n| summarize TotalCount = count() by LogEntry, ApplicationName \n| top 10 by TotalCount\n\n",
                  "PartTitle": "Top 10 logs by count",
                  "PartSubTitle": "${aks_name}"
                }
              }
            }
          },
          "7": {
            "position": {
              "x": 0,
              "y": 13,
              "colSpan": 18,
              "rowSpan": 5
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
                      "${aks_resource_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "74c6b5f3-5300-4572-8e14-0b143a5650ab",
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
                  "value": "Perf\n| where ObjectName == \"K8SContainer\" and CounterName in (\"memoryRssBytes\", \"memoryWorkingSetBytes\", \"cpuUsageNanoCores\")\n| extend PodUid = tostring(split(InstanceName, \"/\")[-2]), Usage = toint(CounterValue)\n| join (KubePodInventory)\non PodUid\n| summarize avg(Usage) by ControllerName, CounterName\n",
                  "isOptional": true
                },
                {
                  "name": "ControlType",
                  "value": "FrameControlChart",
                  "isOptional": true
                },
                {
                  "name": "SpecificChart",
                  "value": "UnstackedColumn",
                  "isOptional": true
                },
                {
                  "name": "PartTitle",
                  "value": "Analytics",
                  "isOptional": true
                },
                {
                  "name": "PartSubTitle",
                  "value": "${aks_name}",
                  "isOptional": true
                },
                {
                  "name": "Dimensions",
                  "value": {
                    "aggregation": "Sum",
                    "splitBy": [
                      {
                        "name": "CounterName",
                        "type": "string"
                      }
                    ],
                    "xAxis": {
                      "name": "ControllerName",
                      "type": "string"
                    },
                    "yAxis": [
                      {
                        "name": "memoryRssBytesUsage",
                        "type": "real"
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
                  "Query": "Perf\n| where ObjectName == \"K8SContainer\" and CounterName in (\"memoryRssBytes\", \"memoryWorkingSetBytes\", \"cpuUsageNanoCores\")\n| extend PodUid = tostring(split(InstanceName, \"/\")[-2]), Usage = toint(CounterValue)\n| join kind = inner (KubePodInventory | where Namespace == \"${aks_namespace}\")\non PodUid\n| summarize toint(avg(Usage)) by ControllerName, CounterName\n",
                  "PartTitle": "Resource consumption by service",
                  "Dimensions": {
                    "aggregation": "Sum",
                    "splitBy": [
                      {
                        "name": "CounterName",
                        "type": "string"
                      }
                    ],
                    "xAxis": {
                      "name": "ControllerName",
                      "type": "string"
                    },
                    "yAxis": [
                      {
                        "name": "avg_Usage",
                        "type": "int"
                      }
                    ]
                  }
                }
              }
            }
          },
          "8": {
            "position": {
              "x": 0,
              "y": 18,
              "colSpan": 18,
              "rowSpan": 5
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
                      "${aks_resource_id}"
                    ]
                  },
                  "isOptional": true
                },
                {
                  "name": "PartId",
                  "value": "8a16297b-e811-4bbe-8590-e0b619cc52d9",
                  "isOptional": true
                },
                {
                  "name": "Version",
                  "value": "2.0",
                  "isOptional": true
                },
                {
                  "name": "TimeRange",
                  "value": "PT1H",
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
                  "value": "let terminatingPods = (KubePodInventory| where PodStatus has \"Terminating\"| project PodUid);\nKubePodInventory\n| where PodUid !in~ (terminatingPods)\n| extend app = tostring(parse_json(PodLabel)[0][\"app\"])\n| distinct PodUid, app\n| summarize TotalCount = count() by app\n",
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
                  "value": "${aks_name}",
                  "isOptional": true
                },
                {
                  "name": "Dimensions",
                  "value": {
                    "aggregation": "Sum",
                    "splitBy": [],
                    "xAxis": {
                      "name": "app",
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
                  "Query": "let data = materialize(\n    InsightsMetrics\n    | where Name == \"kube_deployment_status_replicas_ready\"\n    | extend Tags = parse_json(Tags)\n    | extend ClusterId = Tags[\"container.azm.ms/clusterId\"]\n    | where \"a\" == \"a\"\n    | where Tags.k8sNamespace in (\"${aks_namespace}\")\n    | extend Deployment = tostring(Tags.deployment)\n    | extend k8sNamespace = tostring(Tags.k8sNamespace)\n    | extend\n      Ready = Val / Tags.spec_replicas * 100,\n      Updated = Val / Tags.status_replicas_updated * 100,\n      Available = Val / Tags.status_replicas_available * 100\n    | project k8sNamespace, Deployment, Ready, Updated, Available, TimeGenerated, Tags\n    );\nlet data2 = data\n    | extend Age = (now() - todatetime(Tags[\"creationTime\"])) / 1m\n    | summarize arg_max(TimeGenerated, *) by k8sNamespace, Deployment\n    | project k8sNamespace, Deployment, Age, Ready, Updated, Available;\nlet ReadyData = data\n    | make-series ReadyTrend = avg(Ready) default = 0 on TimeGenerated from ago(21600000ms) to now() step 10m by k8sNamespace, Deployment;\nlet UpdatedData = data\n    | make-series UpdatedTrend = avg(Updated) default = 0 on TimeGenerated from ago(21600000ms) to now() step 10m by k8sNamespace, Deployment;\nlet AvailableData = data\n    | make-series AvailableTrend = avg(Available) default = 0 on TimeGenerated from ago(21600000ms) to now() step 10m by k8sNamespace, Deployment;\n    data2\n| join kind = inner(ReadyData) on k8sNamespace, Deployment\n| join kind = inner(UpdatedData) on k8sNamespace, Deployment\n| join kind = inner(AvailableData) on k8sNamespace, Deployment\n| extend\n  ReadyCase = case(Ready == 100, \"Healthy\", \"Warning\"),\n  UpdatedCase = case(Updated == 100, \"Healthy\", \"Warning\"),\n  AvailableCase = case(Available == 100, \"Healthy\", \"Warning\")\n| extend Overall = case(ReadyCase == \"Healthy\" and UpdatedCase == \"Healthy\" and AvailableCase == \"Healthy\", \"Healthy\", \"Warning\")\n| extend OverallFilterStatus = case('*' contains \"Healthy\", \"Healthy\", '*' contains \"Warning\", \"Warning\", \"Healthy, Warning\")\n| where OverallFilterStatus has Overall\n| project\n  Deployment,\n  Namespace = k8sNamespace,\n  Ready,\n  Updated,\n  Available\n| sort by Ready asc",
                  "SpecificChart": "PercentageColumn",
                  "PartTitle": "MS Health Status",
                  "Dimensions": {
                    "xAxis": {
                      "name": "Deployment",
                      "type": "string"
                    },
                    "yAxis": [
                      {
                        "name": "Ready",
                        "type": "real"
                      }
                    ],
                    "splitBy": [
                      {
                        "name": "Namespace",
                        "type": "string"
                      }
                    ],
                    "aggregation": "Sum"
                  },
                  "name": "IsQueryContainTimeRange",
				  "value": false,
                  "isOptional": true
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
                "format": "local",
                "granularity": "auto",
                "relative": "30m"
              },
              "displayCache": {
                "name": "Local Time",
                "value": "Past 30 minutes"
              },
              "filteredPartIds": [
                "StartboardPart-MonitorChartPart-417277c1-0210-4ecc-8f50-79da1e771724",
                "StartboardPart-MonitorChartPart-417277c1-0210-4ecc-8f50-79da1e771726",
                "StartboardPart-MonitorChartPart-417277c1-0210-4ecc-8f50-79da1e771728",
                "StartboardPart-MonitorChartPart-417277c1-0210-4ecc-8f50-79da1e77172a",
                "StartboardPart-MonitorChartPart-417277c1-0210-4ecc-8f50-79da1e77172c",
                "StartboardPart-LogsDashboardPart-417277c1-0210-4ecc-8f50-79da1e77172e",
                "StartboardPart-LogsDashboardPart-417277c1-0210-4ecc-8f50-79da1e771730",
                "StartboardPart-LogsDashboardPart-417277c1-0210-4ecc-8f50-79da1e771732",
                "StartboardPart-LogsDashboardPart-417277c1-0210-4ecc-8f50-79da1e7717b3"
              ]
            }
          }
        }
      }
    }
}