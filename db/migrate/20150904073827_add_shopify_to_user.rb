class AddShopifyToUser < ActiveRecord::Migration
  def change
    add_column :users, :shopify, :string
    add_column :users, :teechip, :string
    add_column :users, :teespring, :string
    add_column :users, :represent, :string
  end
end
