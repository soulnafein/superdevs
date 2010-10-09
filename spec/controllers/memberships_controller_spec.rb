require 'spec_helper'

describe MembershipsController do
  before :each do
    UserSession.stub(:find).and_return(mock_session)
  end

  describe "Joining a group" do
    it "should add a user to the group member" do
      Group.stub(:find_active_by_unique_name).with('superdevs').
          and_return(mock_group)

      Membership.should_receive(:create).with(:group => mock_group, :user => mock_user)
      post :create, {:group_id => 'superdevs'}

      response.should redirect_to group_url(mock_group.unique_name)
    end
  end

  describe "Disjoin from a group" do
    before :each do
 #     @a_group = Group.new do |g|
 #       g.id = 'superdevs'
 #       g.unique_name = 'superdevs'
 #     end
      @a_membership = Membership.new do |m|
        m.id = 18
        m.user = mock_user
        #m.group = @a_group
        m.group = mock_group
      end
    end

    it "should remove the user from the group member" do
      Membership.should_receive(:find).with(@a_membership.id).and_return(@a_membership)
      Membership.should_receive(:delete).with(@a_membership.id)
      Group.should_receive(:find_active_by_unique_name).with(mock_group.unique_name).and_return(mock_group)
      delete :destroy, {:id => @a_membership.id, :group_id => mock_group.unique_name}

      response.should redirect_to group_url(mock_group)
    end

    it "should forbid user from removing other group membership" do
      another_user_membership = Membership.new do |m|
        m.id = 14
        m.user = mock_model(User)
        m.group = mock_group
      end
      Membership.stub(:find).with(@a_membership.id).and_return(another_user_membership)
      Group.should_receive(:find_active_by_unique_name).with(mock_group.unique_name).and_return(mock_group)
      delete :destroy, {:id => 18, :group_id => mock_group.unique_name}
      response.status.should == 403
    end
  end

  private 
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

