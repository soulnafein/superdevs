require 'spec_helper'

describe MembershipsController do
  include SessionTestHelper

  before :each do
    @user = Factory.build(:user, :id => 1)
    logged_in_user_is(@user)
    @the_group = Factory.build(:group, :id => 1)
  end

  describe "Joining a group" do
    it "should add a user to the group member" do
      Group.stub(:find_active_by_unique_name).with(@the_group.unique_name).
          and_return(@the_group)

      Membership.should_receive(:create).with(:group => @the_group, :user => @user)
      post :create, {:group_id => @the_group.unique_name}

      response.should redirect_to group_url(@the_group.unique_name)
    end
  end

  describe "Disjoin from a group" do
    before :each do
      @a_membership = Factory.build(:membership, :user => @user)
    end

    it "should remove the user from the group member" do
      Membership.should_receive(:find).with(@a_membership.id).and_return(@a_membership)
      Membership.should_receive(:delete).with(@a_membership.id)
      Group.should_receive(:find_active_by_unique_name).with(@the_group.unique_name).and_return(@the_group)
      delete :destroy, {:id => @a_membership.id, :group_id => @the_group.unique_name}

      response.should redirect_to group_url(@the_group)
    end

    it "should forbid user from removing other group membership" do
      another_user_membership = Factory.build(:membership, :id => 42, :user => Factory.build(:ken))
      Membership.stub(:find).with(@a_membership.id).and_return(another_user_membership)
      Group.should_receive(:find_active_by_unique_name).with(@the_group.unique_name).and_return(@the_group)
      delete :destroy, {:id => 18, :group_id => @the_group.unique_name}
      response.status.should == 403
    end
  end
end

