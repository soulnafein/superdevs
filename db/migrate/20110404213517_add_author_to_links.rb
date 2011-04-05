class AddAuthorToLinks < ActiveRecord::Migration
  def self.up
    add_column :links, :author_id, :integer
  end

  def self.down
    remove_column :links, :author_id
  end
end
