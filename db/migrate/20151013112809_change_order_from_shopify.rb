class ChangeOrderFromShopify < ActiveRecord::Migration
  def change
    remove_column :shopify_stats, :order
    add_column :shopify_stats, :order, :integer, default: 0
  end
end
