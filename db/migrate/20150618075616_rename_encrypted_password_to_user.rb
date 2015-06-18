class RenameEncryptedPasswordToUser < ActiveRecord::Migration
  def change
  	rename_column :users, :encrypted_password, :passwordhash
  end
end
