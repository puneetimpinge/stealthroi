class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string :first_name
      t.string :last_name
      t.integer :amount
      t.string :transaction_id
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :payments, :users
  end
end
