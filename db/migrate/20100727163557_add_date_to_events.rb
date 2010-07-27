class AddDateToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :date, :datetime
  end

  def self.down
    remove_column :events, :date
  end
end
