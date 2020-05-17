view: staff {
  sql_table_name: `aginic-data-warehouse.analytics.staff`
    ;;

  dimension: change {
    type: string
    sql: ${TABLE}.change ;;
  }

  dimension: chapter {
    type: string
    sql: ${TABLE}.chapter ;;
  }

  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: cost_rate {
    type: string
    sql: ${TABLE}.cost_rate ;;
  }

  dimension: cost_type {
    type: string
    sql: ${TABLE}.cost_type ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: email_alias {
    type: string
    sql: ${TABLE}.email_alias ;;
  }

  dimension_group: employment_start {
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
    sql: ${TABLE}.employment_start_date ;;
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

  dimension: fte {
    type: string
    sql: ${TABLE}.FTE ;;
  }

  dimension: full_name {
    type: string
    sql: ${TABLE}.full_name ;;
  }

  dimension: item_sk {
    type: string
    sql: ${TABLE}.item_sk ;;
  }

  dimension: job_title {
    type: string
    sql: ${TABLE}.job_title ;;
  }

  dimension: level {
    type: string
    sql: ${TABLE}.level ;;
  }

  dimension: phone {
    type: string
    sql: ${TABLE}.phone ;;
  }

  dimension_group: probation_end {
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
    sql: ${TABLE}.probation_end_date ;;
  }

  dimension: squad {
    type: string
    sql: ${TABLE}.squad ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: t_shirt_colour {
    type: string
    sql: ${TABLE}.T_shirt_colour ;;
  }

  dimension: t_shirt_cut {
    type: string
    sql: ${TABLE}.T_shirt_cut ;;
  }

  dimension: t_shirt_size {
    type: string
    sql: ${TABLE}.T_shirt_size ;;
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

  dimension: type_of_employee {
    type: string
    sql: ${TABLE}.type_of_employee ;;
  }

  measure: count {
    type: count
    drill_fields: [full_name]
  }
}
