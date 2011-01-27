class AddUniqueIdentifierToEvent < ActiveRecord::Migration
  def self.up
    add_column :events, :unique_identifier, :string
  end

  def self.down
    remove_column :events, :unique_identifier
  end
end
