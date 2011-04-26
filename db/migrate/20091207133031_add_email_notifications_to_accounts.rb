class AddEmailNotificationsToAccounts < ActiveRecord::Migration
  def self.up
    add_column :accounts, :email_notifications, :string, :default => "none"
  end

  def self.down
    remove_column :accounts, :email_notifications
  end
end
