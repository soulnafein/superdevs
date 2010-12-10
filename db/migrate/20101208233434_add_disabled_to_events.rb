class AddDisabledToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :disabled, :boolean, :default => false
  end

  def self.down
    remove_column :events, :disabled
  end
end
