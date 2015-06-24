class AddPaymentToUser < ActiveRecord::Migration
  def change
    add_column :users, :payment_status, :string, default: "false"
  end
end
