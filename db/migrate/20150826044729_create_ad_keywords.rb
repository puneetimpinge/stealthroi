class CreateAdKeywords < ActiveRecord::Migration
  def change
    create_table :ad_keywords do |t|
      t.string :group_id
      t.string :campaign_id
      t.string :target_domain
      t.string :target_page
      t.string :name
      t.float :ctr
      t.float :cpm
      t.float :cpc
      t.float :totalspend
      t.integer :conversions
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :ad_keywords, :users
  end
end
