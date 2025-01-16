metric_alerts = {
  "is_db_alive" = {
    description = "Is DB Alive"
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
