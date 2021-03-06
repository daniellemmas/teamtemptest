view: aginic_team_temp_data_v2 {
  sql_table_name: `aginic-data-warehouse.analytics.team_temp_responses`
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
    sql: ${TABLE}.date_submitted ;;
  }

  dimension: week {
    type: date_week
    sql:  PARSE_TIMESTAMP('%F',CAST(${TABLE}.date_submitted AS STRING)) ;;
  }

  dimension: free_text_thoughts {
    type: string
    sql: ${TABLE}.free_text_thoughts ;;
  }
  dimension: session_token {
    type: string
    primary_key: yes
    sql: ${TABLE}.session_token ;;
  }

  dimension: squad {
    type: string
    sql: ${TABLE}.squad ;;
  }

  dimension: week_score {
    type: number
    sql: ${TABLE}.score ;;
  }

  dimension: squad_connection {
    type: number
    sql: ${TABLE}.squad_connection ;;
  }

  dimension: tough_issues {
    type: number
    sql:  ${TABLE}.tough_issues ;;
  }

  dimension: valued {
    type: string
    sql:  ${TABLE}.valued ;;
  }

  dimension: count_of_team {
    type: number
    sql:  ${TABLE}.squad_member_count ;;
  }

# Option 3 dimensions
  dimension: interest {
    type: number
    sql:  ${TABLE}.interest ;;
  }

  dimension: work_load {
    type: number
    sql: ${TABLE}.workload ;;
  }


# ARCHIVE dimensions ---------------------------------
  dimension: innovation_constant_improvement {
    type: number
    sql: (${TABLE}.innovation) ;;
  }
  dimension: covid_impact {
    type: number
    sql: ${TABLE}.covid_impact ;;
  }



# MEASURES -------------------------------------------

# Total number of Aginic team
  measure: sum_of_team {
    type:  sum_distinct
    sql: ${count_of_team} ;;
  }

# Total number of respondents
  measure: count_respondents {
    type: count
    drill_fields: []
  }

# Average of week score
  measure: average {
    type: average
    sql:  ${week_score} ;;
    drill_fields: []
  }

# Number of team that have responded good, ok or not good
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


# Percentage of the respondents that have responded good, ok or not good
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

  measure: TEST {
    type: number
    sql:  {% if squad._in_query IS NOT NULL %}
          1
          {% else squad._in_query IS NULL %}
          2
          {% endif %}
    ;;
  }

  #two options: attempt to the join and cross view calculation or end up with the above query

# Percentage of whole team that are good, ok and not good (the number of people who didn't complete the survey is the left over %)
  measure: percent_respondents_good {
    type: number
    sql:  ( SELECT sum${count_good}/sum(${count_of_team})
            FROM aginic-data-warehouse.reference.aginic_team_temp_data_v2
            GROUP BY ${squad}
            )
    ;;
  }
  measure: percent_respondents_ok {
    type: number
    sql:  (${count_ok})/sum(distinct ${aginic_team_temp_data_v2.count_of_team}) ;;
  }

  measure: percent_respondents_not_good {
    type: number
    sql:  (${count_not_good})/sum(distinct ${aginic_team_temp_data_v2.count_of_team}) ;;
  }


# Percentage of each squad that completed the survey
  measure: percent_respondents {
    type: number
    sql:  (${count_respondents})/(${sum_of_team}/${count_respondents}) ;;
  }

# Percentage of company that completed the survey
  measure: total_percent_respondents {
    type: number
    sql:  sum(${aginic_team_temp_data_v2.count_respondents})/sum(${aginic_team_temp_data_v2.count_of_team}) ;;
  }


# SQUAD CONNECTION (Option 3):
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

# WORKLOAD negatively affecting you (Option 3):
  measure: count_work_load_negatively_affecting{
    type:  count
    filters: [work_load: ">=4"]
  }
  measure: count_work_load_somewhat_affecting {
    type:  count
    filters: [work_load: "3"]
  }
  measure: count_work_load_fine{
    type:  count
    filters: [work_load: "<=2"]
  }

# INTEREST (Option 3)
  measure: count_interest_good{
    type:  count
    filters: [interest: ">=4"]
  }
  measure: count_interest_ok {
    type:  count
    filters: [interest: "3"]
  }
  measure: count_interest_not_good{
    type:  count
    filters: [interest: "<=2"]
  }

# VALUED (Option 3)
  measure: count_valued_yes{
    type:  count
    filters: [valued: "TRUE"]
  }
  measure: count_valued_no {
    type:  count
    filters: [valued: "FALSE"]
  }


# ARCHIVE MEASURES ----------------------------------------

# COVID related questions
measure: count_covid_yes {
  type:  count
  filters: [covid_impact: ">=4"]
}

measure: count_covid_somewhat {
  type:  count
  filters: [covid_impact: "3"]
}

measure: count_covid_no {
  type:  count
  filters: [covid_impact: "<=2"]
}
measure: percentage_covid_no {
  type: number
  sql:  (${count_covid_no})/(${count_respondents}) ;;
}

measure: percentage_covid_somewhat {
  type: number
  sql:  (${count_covid_somewhat})/(${count_respondents}) ;;
}

measure: percentage_covid_yes {
  type: number
  sql:  (${count_covid_yes})/(${count_respondents}) ;;
}

# Innovation and constant improvement questions
measure: count_innovation_good {
  type:  count
  filters: [innovation_constant_improvement: ">=4"]
}
measure: count_innovation_ok {
  type:  count
  filters: [innovation_constant_improvement: "3"]
}
measure: count_innovation_not_good {
  type:  count
  filters: [innovation_constant_improvement: "<=2"]
}

}
