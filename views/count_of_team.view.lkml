# If necessary, uncomment the line below to include explore_source.
# include: "aginic_team_temp_data_v2.model.lkml"

view: count_of_team {
  derived_table: {
    explore_source: aginic_team_temp_data_v2 {
      column: squad { field: staff.squad }
      column: count_team { field: staff.count_team }
      filters: {
        field: staff.status
        value: "Current"
      }
      filters: {
        field: staff.to_date
        value: "NULL"
      }
      filters: {
        field: staff.squad
        value: "-None,-Cubiko"
      }
    }
  }
  dimension: squad {

  }
  dimension: count_team {
    type: number
  }
}
