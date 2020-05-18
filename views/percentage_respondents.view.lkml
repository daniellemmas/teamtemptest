# If necessary, uncomment the line below to include explore_source.
#include: "aginic_team_temp_data_v2.model.lkml"

view: percentage_respondents {
  derived_table: {
    explore_source: aginic_team_temp_data_v2 {
      column: count_team { field: staff.count_team }
      column: count_respondents {}
      column: squad { field: staff.squad }
      filters: {
        field: staff.squad
        value: "-Directors,-None,-Cubiko,-NULL"
      }
      filters: {
        field: staff.to_date
        value: "NULL"
      }
    }
  }
  dimension: count_team {
    type: number
  }
  dimension: count_respondents {
    type: number
  }
  dimension: squad {

  }
  measure: percentage_respondents {
    type: number
    sql: sum(${count_respondents})/sum(${count_team}) ;;
  }
}
