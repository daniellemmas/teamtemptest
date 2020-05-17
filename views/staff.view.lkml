view: staff {
  sql_table_name: `aginic-data-warehouse.analytics.staff`
    ;;



  dimension: squad {
    type: string
    primary_key: yes
    sql: ${TABLE}.squad ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
  measure: count_current {
    type: count
    filters: [status: "Current"]
}
}
