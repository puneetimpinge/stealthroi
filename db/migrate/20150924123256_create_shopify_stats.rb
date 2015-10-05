class CreateShopifyStats < ActiveRecord::Migration
  def change
    create_table :shopify_stats do |t|
      t.string :order
      t.string :created_time
      t.float :price
      t.references :user, index: true

      t.timestamps null: false
    end
  end
end
