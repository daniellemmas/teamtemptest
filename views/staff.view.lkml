view: staff {
  sql_table_name: `aginic-data-warehouse.analytics.staff`
    ;;

  dimension: change {
    type: string
    sql: ${TABLE}.change ;;
  }

  dimension_group: from {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.from_date ;;
  }

  dimension: full_name {
    type: string
    sql: ${TABLE}.full_name ;;
  }


  dimension: squad {
    type: string
    sql: ${TABLE}.squad ;;
  }

  dimension: status {
    type: string

    sql: ${TABLE}.status ;;
  }

  dimension_group: to {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.to_date ;;
  }

  measure: count {
    type: count
    drill_fields: [full_name]
  }
  measure: count_current {
    type: count_distinct
    sql: ${TABLE}.full_name ;;
    filters: [status: "Current"]
}
}
