class AddAuthenticationFieldsToPeople < ActiveRecord::Migration
  def self.up
    add_column :people, :username, :string
    add_column :people, :crypted_password, :string
    add_column :people, :password_salt, :string
    add_column :people, :persistence_token, :string
  end

  def self.down
    remove_column :people, :persistence_token
    remove_column :people, :password_salt
    remove_column :people, :crypted_password
    remove_column :people, :username
  end
end
