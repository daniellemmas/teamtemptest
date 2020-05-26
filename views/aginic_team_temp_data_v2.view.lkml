view: aginic_team_temp_data_v2 {
  sql_table_name: `aginic-data-warehouse.reference.aginic_team_temp_data_v2`
    ;;

  dimension_group: date_submitted {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year,
      time
    ]
    sql: ${TABLE}.DateSubmitted ;;
  }

  dimension: week {
    type: date_week
    sql:  PARSE_TIMESTAMP('%F',CAST(${TABLE}.DateSubmitted AS STRING)) ;;
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
  dimension: work_load {
    type: number
    sql: ${TABLE}.WorkLoad ;;
  }
  dimension: proud_of_work {
    type: number
    sql: CAST(${TABLE}.ProudOfWork as INT64) ;;
  }
  dimension: squad_connection {
    type: number
    sql: ${TABLE}.SquadConnection ;;
  }
  dimension: count_of_team {
    type: number
    sql:  ${TABLE}.CountOfTeam ;;
  }

  measure: sum_of_team {
    type:  sum
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
    filters: [week_score: "<= 2"]
  }
  measure: count_ok {
    type:  count
    filters: [week_score: "3"]
  }
  measure: count_good {
    type:  count
    filters: [week_score: ">= 4"]
  }
  measure: percentage_not_good {
    type: number
    sql:  (${count_not_good})/(${count_respondents}) ;;
  }
  measure: percentage_ok {
    type: number
    sql:  (${count_ok})/(${count_respondents}) ;;
  }
  measure: percentage_good {
    type: number
    sql:  (${count_good})/(${count_respondents}) ;;
  }
  measure: count_connection_good {
    type:  count
    filters: [squad_connection: ">=4"]
  }
  measure: count_connection_ok {
    type:  count
    filters: [squad_connection: "3"]
  }
  measure: count_connection_not_good {
    type:  count
    filters: [squad_connection: "<=2"]
  }

  measure: count_pride_good {
    type:  count
    filters: [proud_of_work: ">=4"]
  }
  measure: count_pride_ok {
    type:  count
    filters: [proud_of_work: "3"]
  }
  measure: count_pride_not_good {
    type:  count
    filters: [proud_of_work: "<=2"]
  }

  measure: count_work_load_too_much{
    type:  count
    filters: [work_load: ">=4"]
  }
  measure: count_work_load_perfect {
    type:  count
    filters: [work_load: "3"]
  }
  measure: count_work_load_not_enough{
    type:  count
    filters: [work_load: "<=2"]
  }
  measure: percent_respondents {
    type: number
    sql:  (${sum_of_team})/(${count_of_team}) ;;
  }
}
