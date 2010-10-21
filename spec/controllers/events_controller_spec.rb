require 'spec_helper'
 
describe EventsController do
  describe "GET 'new'" do
    before :each do
      UserSession.stub(:find).and_return(mock_session)
    end

    it "should provide the group when adding an event for a group" do
      group = Group.new do |g|
        g.organizer = mock_user
      end
      Group.stub(:find_active_by_unique_name).with('london-developers').
              and_return(group)

      get :new, :group_id => 'london-developers'

      assigns(:event).group.should == group
    end

    it "should only allow editing by the organiser of the group" do
      group = Group.new do |g|
        g.organizer = mock_model(User)
      end
      Group.stub(:find_active_by_unique_name).with("london-developers").
              and_return(group)
      valid_info = {:group_id => "london-developers"}

      get :new, valid_info

      response.status.should == 403
    end
  end

  describe "GET 'edit'" do
    before :each do
      UserSession.stub(:find).and_return(mock_session)
    end

    it "should provide the event when editing an event for a group" do
      group = mock_model(Group)
      event = mock_model(Event, :group => group, :is_organizer? => true)
      Event.stub(:find).with(42).and_return(event)

      get :edit, {:group_id => 'london-developers', :id => 42}

      assigns(:event).should == event
    end

    it "should only allow editing by the organiser of the group" do
      group = mock_model(Group)
      event = mock_model(Event, :group => group, :is_organizer? => false)
      Event.stub(:find).with(42).and_return(event)

      get :edit, {:group_id => "london-developers", :id => 42}

      response.status.should == 403
    end
  end
  describe "PUT 'update'" do
    before :each do
      UserSession.stub(:find).and_return(mock_session)
    end

    it "should update the event" do
      Event.stub(:find).with("42").and_return(mock_event)
      valid_info = {:id => "42",
                    :group_id => 'london-developers',
                    :event => {"description" => "a description"}}
      mock_event.should_receive(:update_attributes!).with(valid_info[:event])

      put :update, valid_info

      response.should redirect_to group_event_url(mock_event.group.unique_name, mock_event.id)
    end

    it "should only allow editing by the organiser of the group" do
      group = mock_model(Group).as_null_object
      event = mock_model(Event, :group => group, :is_organizer? => false)
      Event.stub(:find).with(42).and_return(event)

      put :update, {:group_id => "london-developers", :id => 42}

      response.status.should == 403
    end
  end

  describe "GET 'show'" do
    before :each do
      UserSession.stub(:find).and_return(mock_session)
    end

    it "should load the event from the database" do
      event = mock(:event)
      Event.stub(:find).with(42).and_return(event)

      get :show, :id => 42

      response.should be_success
    end

    it "should only allow event creation by the organiser of the group" do
      group = Group.new do |g|
        g.organizer = mock_model(User)
      end
      Group.stub(:find_active_by_unique_name).with("london-developers").
              and_return(group)

      valid_post = {:event => {:title => "Geek night", :city => "London",
                               :country => "United Kingdom",
                               :description => "A geek night",
                               :date=>"10-10-2010"},
                               :group_id => "london-developers" }

      post :create, valid_post

      response.status.should == 403
    end
  end

  def mock_event(stubs={})
    event = mock_model(Event, stubs).as_null_object
    event.stub(:group).and_return(mock_model(Group, :unique_name => "london-developers"))
    @mock_event ||=  event
  end


  def mock_session
    session = mock(UserSession).as_null_object
    session.stub(:record).and_return(mock_user)
    @mock_session ||= session
  end

  def mock_user(stubs={})
    @mock_user ||= mock_model(User, stubs).as_null_object
  end
end
