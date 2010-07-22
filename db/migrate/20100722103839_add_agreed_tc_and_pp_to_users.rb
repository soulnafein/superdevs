class AddAgreedTcAndPpToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :agreed_tc_and_pp, :boolean, :default => false
  end

  def self.down
    remove_column :users, :agreed_tc_and_pp
  end
end
