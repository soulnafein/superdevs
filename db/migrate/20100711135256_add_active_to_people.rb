class AddActiveToPeople < ActiveRecord::Migration
  def self.up
    add_column :people, :active, :boolean
  end

  def self.down
    remove_column :people, :active
  end
end
