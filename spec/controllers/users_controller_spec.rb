require 'spec_helper'

describe UsersController do
  include SessionTestHelper

  describe "GET 'show'" do
    it "should load the user from the database" do
      @user = Factory(:user)
      User.stub(:find_active_by_username).with(42).and_return(@user)

      get :show, :id => 42

      response.should be_success
      assigns(:user).should == @user
    end

    it "should send back a 404 when give an invalid id" do
      get :show, :id => 666

      response.status.should == 404
    end
  end

  describe "GET 'edit'" do
    before :each do
      @user = Factory(:user)
      logged_in_user_is(@user)
    end

    it "should load the user from the database" do
      User.stub(:find_active_by_username).with(42).and_return(@user)

      get :edit, :id => 42

      response.should be_success
      assigns(:user).should == @user
    end

    it "should send back a 404 when give an invalid id" do
      get :edit, :id => 666

      response.status.should == 404
    end
  end

  describe "PUT 'update'" do
    before :each do
      @user = Factory(:user, :id => 1)
      logged_in_user_is(@user)
    end

    it "should update user" do
      User.stub(:find_active_by_username).with(1).and_return(@user)
      valid_info = {:id => 1, :user => {"username" => "soulnafein", "email" => "soulnafe@gmail.com", "password" => "test", "password_confirmation" => 'test'}}
      @user.should_receive(:update_attributes!).with(valid_info[:user])

      put :update, valid_info

      response.should redirect_to user_url(@user) 
    end

    it "should go back to form in case of errors" do
      User.stub(:find_active_by_username).with(1).and_return(mock_user_with_errors)
      mock_user.should_receive(:update_attributes!).and_raise(ActiveRecord::RecordInvalid.new(mock_user_with_errors))
      invalid_info = {:id => 1, :user => {"username" => "soulnafein", "email" => "soulnafe@gmail.com.", "password" => "test", "password_confirmation" => 'testsss'}}

      put :update, invalid_info

      response.should render_template(:edit)
    end
  end

  describe "GET 'new" do
    it "should provide an empty user to the page" do
      get :new

      response.should be_success
      assigns(:user).should_not be_nil
    end
  end

  describe "POST 'create'" do
    it "should save user" do
      User.stub(:new).and_return(@user)
      @user.should_receive(:save!)
      @user.should_receive(:deliver_activation_instructions!)
      valid_signup = {:user => {:username => "soulnafein", :email => "soulnafe@gmail.com", :password => "test", :password_confirmation => 'test'}}

      post :create, valid_signup 

      response.should redirect_to("/invitation_requested")
    end

    it "should go back to form in case of errors" do
      User.stub(:new).and_return(mock_user_with_errors)
      mock_user.should_receive(:save!).and_raise(ActiveRecord::RecordInvalid.new(mock_user_with_errors))
      invalid_signup = {:user => {:username => "soulnafein", :email => "soulnafe@gmail.com.", :password => "test", :password_confirmation => 'testsss'}}

      post :create, invalid_signup

      response.should render_template(:new)
    end
  end

  describe "GET 'index'" do
    it "should provide a list of all the active developers" do
      active_users = [@user, @user]
      User.should_receive(:all_active_users).and_return(active_users)

      get :index

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
