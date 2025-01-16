metric_alerts = {
  "is_db_alive" = {
    name        = "is_db_alive"
    description = "Is DB Alive"
    scopes = [
      "/subscriptions/8fad0848-88a3-4620-bee0-1e65e1206c73/resourceGroups/hygtmp-apim-northeurope-dev-001-rg-001"
    ]
    criterias = {
      "is_db_alive_lt_min" = {
        threshold        = 1
        metric_name      = "is_db_alive"
        metric_namespace = "Microsoft.DBforPostgreSQL/flexibleServers"
        operator         = "LessThan"
        aggregation      = "Minimum"
        dimensions       = {}
      }
    }
    action_groups = ["db-failures"]
  }
}
