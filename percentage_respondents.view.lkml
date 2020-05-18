# If necessary, uncomment the line below to include explore_source.
# include: "aginic_team_temp_data_v2.model.lkml"

view: precentage_respondents {
  derived_table: {
    explore_source: aginic_team_temp_data_v2 {
      column: squad { field: staff.squad }
      column: count {}
      column: count { field: staff.count }
      filters: {
        field: staff.to_date
        value: "NULL"
      }
      filters: {
        field: staff.squad
        value: "-None,-Cubiko,-Directors,-NULL"
      }
    }
  }
  dimension: squad {}
  dimension: count {
    type: number
  }
  dimension: count_percentage {
    type: number
  }
  measure: total_percentage {
    type: sum
    sql: sum(${count} ;;

  }
}
