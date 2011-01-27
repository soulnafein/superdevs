require 'spec_helper'

describe GroupsController do
  include SessionTestHelper

  describe "GET 'show'" do
    it "should load the group from the database" do
      @the_group = Factory.build(:group)
      Group.stub(:find_active_by_unique_name).with("london-developers").
            and_return(@the_group)

      get :show, :id => "london-developers"

      response.should be_success
      assigns(:group).should == @the_group
    end

    it "should send back a 404 when give an invalid id" do
      get :show, :id => "i-dont-exist"

      response.status.should == 404
    end
  end

  describe "GET 'index'" do
    it "should load all the active groups from the database" do
      @the_group = Factory.build(:group)
      groups = [@the_group, @the_group]
      Group.stub(:all_active).and_return(groups)

      get :index

      response.should be_success
      assigns(:groups).should == groups
    end
  end

  describe "GET 'edit'" do
    before :each do
      @user = Factory.build(:user, :id => 1)
      logged_in_user_is(@user)
    end

    it "should load the group from the database" do
      @the_group = Factory.build(:group, :organizer => @user)
      Group.stub(:find_active_by_unique_name).with("london-developers").
              and_return(@the_group)

      get :edit, :id => "london-developers"

      response.should be_success
      assigns(:group).should == @the_group
    end

    it "should only allow editing by the organiser of the group" do
      @the_group = Factory.build(:group, :organizer => Factory.build(:ken, :id => 2))
      Group.stub(:find_active_by_unique_name).with("london-developers").
              and_return(@the_group)

      get :edit, :id => "london-developers"

      response.status.should == 403
    end
  end

  describe "PUT 'update'" do
    before :each do
      @user = Factory.build(:user, :id => 1)
      logged_in_user_is(@user)
    end

    it "should update the group" do
      @the_group = mock_model(Group).as_null_object
      Group.stub(:find_active_by_unique_name).with("london-developers").
              and_return(@the_group)
      valid_info = {:id => "london-developers",
                    :group => {"description" => "a description"}}
      @the_group.should_receive(:update_attributes!).with(valid_info[:group])

      put :update, valid_info
      response.should redirect_to group_url(@the_group.unique_name)
    end

    it "should only allow editing by the organiser of the group" do
      @the_group = Factory.build(:group, :organizer => Factory.build(:ken, :id => 2))

      Group.stub(:find_active_by_unique_name).with("london-developers").
              and_return(@the_group)
      valid_info = {:id => "london-developers",
                    :group => {"description" => "a description"}}

      put :update, valid_info

      get :update, :id => "london-developers"

      response.status.should == 403
    end
  end
end
