require 'spec_helper'

describe UsersController do
  include SessionTestHelper

  describe "GET 'show'" do
    it "should load the user from the database" do
      @user = Factory.build(:user)
      User.stub(:find_active_by_username).with(42).and_return(@user)

      get :show, :id => 42

      response.should be_success
      assigns(:user).should == @user
    end

    it "should send back a 404 when give an invalid id" do
      get :show, :id => '666'

      response.status.should == 404
    end
  end

  describe "GET 'edit_accounts'" do
    before :each do
      @user = Factory.build(:user)
      logged_in_user_is(@user)
    end

    it "should load the user from the database" do
      User.stub(:find_active_by_username).with(42).and_return(@user)

      get :edit_accounts, :id => 42

      response.should be_success
      assigns(:user).should == @user
    end

    it "should send back a 404 when give an invalid id" do
      get :edit_accounts, :id => '666'

      response.status.should == 404
    end
  end

  describe "PUT 'update'" do
    before :each do
      @user = Factory.build(:user, :id => 1)
      logged_in_user_is(@user)
    end

    it "should update user" do
      User.stub(:find_active_by_username).with(1).and_return(@user)
      valid_info = {:id => 1, :user => {"username" => "soulnafein", "email" => "soulnafe@gmail.com", "password" => "test", "password_confirmation" => 'test'}}
      @user.should_receive(:update_attributes!).with(valid_info[:user])

      put :update, valid_info

      response.should redirect_to user_url(@user) 
    end
  end

  describe "GET 'index'" do

    before :each do
      @user = Factory.build(:user)
      @ken = Factory.build(:ken)
    end

    it "should provide a list of active developers on first page" do
      active_users = [@user, @user]
      User.should_receive(:all_active_users_per_page).and_return(active_users)

      get :index

      response.should be_success
      response.should render_template(:index)
      assigns[:users].should == active_users
    end

    it "should provide a list of active developer on any page" do
      active_users = [@ken, @user]
      page_number = 5
      User.should_receive(:all_active_users_per_page).with(page_number).and_return(active_users)

      get :index, :page => 5

      response.should be_success
      response.should render_template(:index)
      assigns[:users].should == active_users
    end
  end

  def mock_user(stubs={})
    @mock_user ||= mock_model(User, stubs).as_null_object
  end

  def mock_user_with_errors
    errors = mock("errors")
    mock_user.stub!(:errors).and_return(errors)
    errors.stub!(:full_messages).and_return([])
    @mock_user
  end
end
