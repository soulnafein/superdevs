require 'spec_helper'

describe EventsController, "Modifying an existing group's event" do
  include TestBuilders
  include SessionTestHelper

  before :each do
    @david = user_david
    @ken = user_ken
  end

  it "should only be allowed to the group's organizer" do
    logged_in_user_is(@david)
    the_event = event
    the_event.group = group
    the_event.group.organizer = @ken

    Event.stub(:find).with(the_event.id).and_return(event)

    get :edit, {:id => the_event.id}
    response.status.should == 403

    put :update, {:id => the_event.id, :event => {"description" => "Whatever"}}
    response.status.should == 403
  end

  context "When the group event's organizer is logged in" do
    before :each do
      logged_in_user_is(@david)
      @the_event = event
      @the_event.group = group()
      @the_event.group.organizer = @david
      Event.stub(:find).with(@the_event.id).and_return(@the_event)
    end

    it "should show correctly the form and should pass the event to it" do
      get :edit, {:id => @the_event.id}

      response.should be_success
      assigns(:event).should == @the_event
    end

    it "should update the event" do
      valid_params = {:id => @the_event.id, :event => {"description" => "Whatever"}}

      @the_event.should_receive(:update_attributes!).with(valid_params[:event])

      put :update, valid_params

      response.should redirect_to group_event_url("london-developers", @the_event.id)
    end
  end
end