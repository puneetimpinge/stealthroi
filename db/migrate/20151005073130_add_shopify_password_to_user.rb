class AddShopifyPasswordToUser < ActiveRecord::Migration
  def change
    add_column :users, :shopify_password, :string
  end
end
