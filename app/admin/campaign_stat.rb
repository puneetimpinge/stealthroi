ActiveAdmin.register CampaignStat do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :campaign_name, :current_order_count, :current_item_count, :total_sales_amount, :profit,:total_visits,:urlcode,:campaign_id
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end


end
