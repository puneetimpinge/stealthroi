ActiveAdmin.register FbAd do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :adid,:urlcode, :urldomain, :t_spend, :tot_spend, :adgroup_name, :campaign_groupid, :campaign_group_name
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end


end
