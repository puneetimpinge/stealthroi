ActiveAdmin.register User do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
 permit_params :first_name,:last_name, :phone,:avatar, :fname, :viralstyleapikey, :fbadaccount, :accesslevel, :emailverificationcode, :tableprefix, :timezonecode, :payment_status, :fbadaccount
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end


end
