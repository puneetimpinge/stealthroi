class CreateFbAds < ActiveRecord::Migration
  def change
    create_table :fb_ads do |t|
      t.string :adid
      t.string :urlcode
      t.string :urldomain
      t.float :t_spend
      t.float :tot_spend
      t.references :user

      t.timestamps null: false
    end
  end
end
