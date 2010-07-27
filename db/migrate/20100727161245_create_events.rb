class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :title
      t.string :city
      t.string :country
      t.text :description
      t.string :link

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
