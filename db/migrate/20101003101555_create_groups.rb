class CreateGroups < ActiveRecord::Migration
  def self.up
    create_table :groups do |t|
      t.string :unique_name
      t.string :name
      t.references :organizer
      t.text :description
      t.boolean :active

      t.timestamps
    end
  end

  def self.down
    drop_table :groups
  end
end
