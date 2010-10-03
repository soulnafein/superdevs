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

  def mock_group
    @mock_group ||= mock_model(Group)
  end
end
