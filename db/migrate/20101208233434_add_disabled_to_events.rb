class AddDisabledToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :disabled, :bool, :default => 0
  end

  def self.down
    remove_column :events, :disabled
  end
end
