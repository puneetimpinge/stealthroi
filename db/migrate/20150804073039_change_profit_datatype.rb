class ChangeProfitDatatype < ActiveRecord::Migration
  def change
  	change_column :campaign_stats, :profit,  :float
  end
end
