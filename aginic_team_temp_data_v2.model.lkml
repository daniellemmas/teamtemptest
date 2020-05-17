connection: "aginic_datawarehouse"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
# include: "/**/view.lkml"                   # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
explore: aginic_team_temp_data_v2 {
#
join: staff {
relationship: many_to_one
sql_on: ${staff.squad} = ${aginic_team_temp_data_v2.squad} ;;
 }
}

explore: staff {
join: aginic_team_temp_data_v2 {
  relationship: one_to_many
  sql_on: ${aginic_team_temp_data_v2.squad}=${staff.squad};;
}
}
