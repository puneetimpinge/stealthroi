class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :notification_text
      t.integer :notification_unread
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :notifications, :users
  end
end
