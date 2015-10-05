ActiveAdmin.register ShopifyStat do
	permit_params :order, :price, :create_time, :user_id
end