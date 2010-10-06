require 'spec_helper'

describe MembersController do
  before :each do
    UserSession.stub(:find).and_return(mock_session)
  end

  describe "Joining a group" do
    it "should add a user to the group member" do
      Group.stub(:find_active_by_unique_name).with('superdevs').
          and_return(mock_group)

      Member.should_receive(:create).with(:group => mock_group, :user => mock_user)
      get :create, {:id => 'superdevs'}

      response.should redirect_to group_url(mock_group.unique_name)
    end
  end

  describe "Disjoin from a group" do
    it "should remove the user from the group member" 
  end

  def mock_session
    session = mock(UserSession).as_null_object
    session.stub(:record).and_return(mock_user)
    @mock_session ||= session
  end

  def mock_user(stubs={})
    user = User.new(:username => 'dsantoro', :full_name => 'David Santoro',
                    :country => 'United Kingdom', :city => 'London')
    @mock_user ||= user
  end

  def mock_group
    @mock_group ||= mock_model(Group).as_null_object
  end
end

