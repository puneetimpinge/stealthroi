class ChangeOrderFromShopify < ActiveRecord::Migration
  def change
    change_column :shopify_stats, :order, :integer
  end
end
