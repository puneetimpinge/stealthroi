class AddAdgroupNameToFbAd < ActiveRecord::Migration
  def change
    add_column :fb_ads, :adgroup_name, :string
    add_column :fb_ads, :campaign_group_name, :string
    add_column :fb_ads, :campaign_groupid, :string
  end
end
