class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :accesslevel, :integer
    add_column :users, :viralstyleapikey, :string
    add_column :users, :fname, :string
    add_column :users, :emailverificationcode, :string
    add_column :users, :tableprefix, :string
    add_column :users, :timezonecode, :string
  end
end
