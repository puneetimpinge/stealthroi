class CreateFbauthtokens < ActiveRecord::Migration
  def change
    create_table :fbauthtokens do |t|
      t.string :email
      t.string :fbtoken
      t.references :user

      t.timestamps null: false
    end
  end
end
