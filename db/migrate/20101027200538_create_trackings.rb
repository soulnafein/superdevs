class CreateTrackings < ActiveRecord::Migration
  def self.up
    create_table :trackings do |t|
      t.references :user
      t.references :event

      t.timestamps
    end
  end

  def self.down
    drop_table :trackings
  end
end
