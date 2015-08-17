class AddFbadaccountToUser < ActiveRecord::Migration
  def change
    add_column :users, :fbadaccount, :string
  end
end
