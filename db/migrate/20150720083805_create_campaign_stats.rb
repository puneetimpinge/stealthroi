class CreateCampaignStats < ActiveRecord::Migration
  def change
    create_table :campaign_stats do |t|
      t.string :campaign_name
      t.integer :current_order_count
      t.string :current_item_count
      t.integer :total_sales_amount
      t.integer :profit
      t.integer :total_visits
      t.string :urlcode
      t.integer :campaign_id
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :campaign_stats, :users
  end
end
