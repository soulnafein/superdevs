class ActsAsCommentableWithThreadingMigration < ActiveRecord::Migration
  def self.up
    add_column :comments, :commentable_id, :integer, :default => 0
    add_column :comments, :commentable_type, :string, :default => ""
    add_column :comments, :title, :string, :default => ""
    add_column :comments, :subject, :string, :default => ""
    add_column :comments, :parent_id, :integer
    add_column :comments, :lft, :integer
    add_column :comments, :rgt, :integer

    add_index :comments, :author_id
    add_index :comments, :commentable_id
  end
  
  def self.down
    remove_index :comments, :author_id
    remove_index :comments, :commentable_id

    remove_column :comments, :commentable_id
    remove_column :comments, :commentable_type
    remove_column :comments, :title
    remove_column :comments, :subject
    remove_column :comments, :parent_id
    remove_column :comments, :lft
    remove_column :comments, :rgt
  end
end
