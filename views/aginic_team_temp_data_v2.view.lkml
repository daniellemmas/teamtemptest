view: aginic_team_temp_data_v2 {
  sql_table_name: `aginic-data-warehouse.reference.aginic_team_temp_data_v2`
    ;;

  dimension_group: date_submitted {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.DateSubmitted ;;
  }

  dimension: free_text_thoughts {
    type: string
    sql: ${TABLE}.FreeTextThoughts ;;
  }

  dimension: session_token {
    type: string
    primary_key: yes
    sql: ${TABLE}.SessionToken ;;
  }

  dimension: squad {
    type: string
    sql: ${TABLE}.Squad ;;
  }

  dimension: week_score {
    type: number
    sql: ${TABLE}.WeekScore ;;
  }

  measure: count_respondents {
    type: count
    drill_fields: []
  }
  measure: average {
    type: average
    sql:  ${week_score} ;;
    drill_fields: []
  }
  measure: count_not_good {
    type:  count
    filters: [week_score: "1", week_score: "2"]
  }
  measure: count_ok {
    type:  count
    filters: [week_score: "3"]
  }
  measure: count_good {
    type:  count
    filters: [week_score: "4", week_score: "5"]
  }
}
