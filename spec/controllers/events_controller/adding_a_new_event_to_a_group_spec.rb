require 'spec_helper'

describe EventsController, "Adding a new event to a group" do
  include TestBuilders
  include SessionTestHelper

  before :each do
    @david = user_david
    @ken = user_ken
  end

  it "should only be allowed to the group's organizer" do
    logged_in_user_is(@david)
    the_group = group
    the_group.organizer = @ken
    Group.stub(:find_active_by_unique_name).with("london-developers").
            and_return(the_group)

    get :new, {:id => 123, :group_id => "london-developers"}
    response.status.should == 403

    post :create, {:id => 123, :group_id => "london-developers"}
    response.status.should == 403
  end

  context "When the group event's organizer is logged in" do
    before :each do
      logged_in_user_is(@david)
      the_group = group
      the_group.organizer = @david
      Group.stub(:find_active_by_unique_name).with("london-developers").
              and_return(the_group)
    end

    it "should show correctly the from and should pass the group to it" do
      get :new, {:id => 123, :group_id => "london-developers"}

      response.should be_success
      assigns(:event).group.should == the_group
    end

    it "should create an event with the value posted" do
      Event.should_receive(:create!).with()
    end
  end
end