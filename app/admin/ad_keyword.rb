ActiveAdmin.register AdKeyword do
	permit_params :group_id, :campaign_id, :target_domain, :target_page, :name, :ctr, :cpm, :cpc, :totalspent, :conversions
end
