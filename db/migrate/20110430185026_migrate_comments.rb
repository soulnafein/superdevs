class CommentTable < ActiveRecord::Base
  #somehow the comment class in model is not accessible :(
  set_table_name 'comments'
end

class MigrateComments < ActiveRecord::Migration
  def self.up

    CommentTable.find_each do |comment|
      comment.commentable_id = comment.event_id
      comment.commentable_type = Event.to_s
      comment.title = ""
      comment.subject = ""
      comment.save!
    end
  end

  def self.down
  end
end
