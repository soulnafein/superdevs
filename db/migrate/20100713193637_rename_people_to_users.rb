class RenamePeopleToUsers < ActiveRecord::Migration
  def self.up
    rename_table :people, :users
  end

  def self.down
    rename_table :users, :people
  end
end
