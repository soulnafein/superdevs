class AddExtraAuthlogicFieldsToPeople < ActiveRecord::Migration
  def self.up
    add_column :people, :perishable_token, :string
  end

  def self.down
    remove_column :people, :perishable_token
  end
end
