class AddDeliciousUsernameToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :delicious_username, :string
  end

  def self.down
    remove_column :users, :delicious_username
  end
end
