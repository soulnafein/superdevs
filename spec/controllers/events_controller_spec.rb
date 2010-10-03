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

  describe "GET 'show'" do
    before :each do
      UserSession.stub(:find).and_return(mock_session)
    end

    it "should load the event from the database" do
      event = mock(:event)
      Event.stub(:find).with(42).and_return(event)

      get :show, :id => 42

      response.should be_success
      assigns(:event).should == event
    end

    it "should send back a 404 when give an invalid id" do
      get :show, :id => 666

      response.status.should == 404
    end
  end

  describe "GET 'index'" do
    it "should provide a list of events" do
      events = [mock_model(Event), mock_model(Event)]
      Event.stub(:all_upcoming).and_return(events)
      today = Chronic.parse("31 january 2010").to_date
      Date.stub(:today).and_return(today)
      grouped_events = mock(EventsGroupedByPeriod)
      EventsGroupedByPeriod.stub!(:new).with(events, today).
              and_return(grouped_events)

      get :index

      response.should be_success
      assigns(:events).should == grouped_events
    end
  end
  
  describe "POST 'create'" do
    before :each do
      UserSession.stub(:find).and_return(mock_session)
    end

    it "should save event" do
      group = mock_model(Group)
      group.stub(:organizer?).and_return(true)
      group.stub(:unique_name).and_return('london-developers')
      Group.stub(:find_active_by_unique_name).with('london-developers').
              and_return(group)
      Event.stub(:new).and_return(mock_event)
      mock_event.should_receive(:save!)
      mock_event.should_receive(:group=).with(group)

      valid_post = {:group_id => 'london-developers',
                    :event => {:title =>  "Geek night",
                               :city => "London",
                               :country => "United Kingdom",
                               :description => "A geek night",
                               :date=>"10-10-2010"}}

      post :create, valid_post

      response.should redirect_to group_url(group.unique_name)
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
    @mock_event ||= mock_model(Event, stubs).as_null_object
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
