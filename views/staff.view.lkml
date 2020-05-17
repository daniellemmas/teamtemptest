view: staff {
  sql_table_name: `aginic-data-warehouse.analytics.staff`
    ;;

  dimension: squad {
    type: string
    primary_key: yes
    sql: ${TABLE}.squad ;;
  }

  dimension: to_date {
    type: date
    sql:  ${TABLE}.to_date ;;
  }
  dimension: status {
    type: string

    sql: ${TABLE}.status ;;
  }

  measure: count {
    type: count_distinct
    sql: ${TABLE}.email ;;
  }

}
