require 'spec_helper'

describe GroupsController do
  describe "GET 'show'" do
    it "should load the group from the database" do
      Group.stub(:find_active_by_unique_name).with("london-developers").
            and_return(mock_group)

      get :show, :id => "london-developers"

      response.should be_success
      assigns(:group).should == mock_group
    end

    it "should send back a 404 when give an invalid id" do
      get :show, :id => "i-dont-exist"

      response.status.should == 404
    end
  end

  describe "GET 'index'" do
    it "should load all the active groups from the database" do
      groups = [mock_group, mock_group]
      Group.stub(:all_active).and_return(groups)

      get :index

      response.should be_success
      assigns(:groups).should == groups
    end
  end

  describe "GET 'edit'" do
    before :each do
      UserSession.stub(:find).and_return(mock_session)
    end

    it "should load the group from the database" do
      Group.stub(:find_active_by_unique_name).with("london-developers").
              and_return(mock_group)

      get :edit, :id => "london-developers"

      response.should be_success
      assigns(:group).should == mock_group
    end

    it "should only allow editing by the organiser of the group" do
      group = Group.new do |g|
        g.organizer = mock_model(User)
      end
      Group.stub(:find_active_by_unique_name).with("london-developers").
              and_return(group)

      get :edit, :id => "london-developers"

      response.status.should == 403
    end
  end

  describe "PUT 'update'" do
    before :each do
      UserSession.stub(:find).and_return(mock_session)
    end

    it "should update the group" do
      Group.stub(:find_active_by_unique_name).with("london-developers").
              and_return(mock_group)
      valid_info = {:id => "london-developers",
                    :group => {"description" => "a description"}}
      mock_group.should_receive(:update_attributes!).with(valid_info[:group])

      put :update, valid_info

      response.should redirect_to group_url(mock_group.unique_name)
    end

    it "should only allow editing by the organiser of the group" do
      group = Group.new do |g|
        g.organizer = mock_model(User)
      end
      Group.stub(:find_active_by_unique_name).with("london-developers").
              and_return(group)
      valid_info = {:id => "london-developers",
                    :group => {"description" => "a description"}}

      put :update, valid_info

      get :update, :id => "london-developers"

      response.status.should == 403
    end
  end

  def mock_session
    session = mock(UserSession).as_null_object
    session.stub(:record).and_return(mock_user)
    @mock_session ||= session
  end

  def mock_user
    @mock_user ||= mock_model(User).as_null_object
  end

  def mock_group
    @mock_group ||= mock_model(Group).as_null_object
  end
end
