class AddEncryptedEmailToItems < ActiveRecord::Migration
  def self.up
    rename_column :items, :email, :encrypted_email
  end

  def self.down
    rename_column :items, :encrypted_email, :email
  end
end
