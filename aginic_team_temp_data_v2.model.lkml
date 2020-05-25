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
    relationship: many_to_many
    type: full_outer
    sql_on: ${staff.squad} = ${aginic_team_temp_data_v2.squad};;
  }

join: percentage_respondents {
relationship: many_to_many
type: full_outer
sql_on: ${percentage_respondents.squad} = ${aginic_team_temp_data_v2.squad} and ${aginic_team_temp_data_v2.date_submitted_date} = ${percentage_respondents.date_submitted_date_date};;
 }
}
