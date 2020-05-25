# If necessary, uncomment the line below to include explore_source.
# include: "aginic_team_temp_data_v2.model.lkml"

view: percentage_respondents {
  derived_table: {
    explore_source: aginic_team_temp_data_v2 {
      column: count_team { field: staff.count_team }
      column: squad {}
      column: count_respondents {}
      column: date_submitted_date {}
      filters: {
        field: staff.to_date
        value: "NULL"
      }
      filters: {
        field: staff.squad
        value: "-Directors,-None,-Cubiko,-NULL"
      }
      filters: {
        field: staff.status
        value: "Current"
      }
    }
  }
  dimension: count_team {
    type: number
  }

  dimension: squad {
  }

  dimension: count_respondents {
    type: number
  }

  dimension_group: date_submitted_date {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
}
  measure: percentage_respondents {
    type: number
    sql: sum(${count_respondents}/${count_team}) ;;
  }
}
