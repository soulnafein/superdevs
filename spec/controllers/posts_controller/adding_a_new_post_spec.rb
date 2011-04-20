require 'spec_helper'

describe PostsController, "Adding a new post (link, code, other)" do
  include SessionTestHelper

  before :each do
    @david = Factory.build(:david, :id => 1)
  end

  it "should visualise the form for creating links" do
    logged_in_user_is @david

    get :new

    response.should be_success
    assigns(:link).class.should == Link
    assigns(:code_snippet).class.should == CodeSnippet
  end
end