require 'spec_helper'

describe CommentsController, "Adding a new comment to an event" do
  include SessionTestHelper

  before :each do
    @david = Factory.build(:david)
    logged_in_user_is(@david)
  end

  it "should create a comment with the text typed, the right event and the current user as author" do
    valid_params = {:event_id => 123,
                    :comment => {"body" => "Whatever matters to you"}}

    comment_details = {:body => "Whatever matters to you",
                        :event_id => 123,
                        :author => @david}
    Comment.should_receive(:create!).with(comment_details)

    post :create, valid_params

    response.should redirect_to event_url("123")
  end
end
