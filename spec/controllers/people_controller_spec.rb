require 'spec_helper'

describe PeopleController do
  describe "GET 'show'" do
    it "should load the person from the database" do
      Person.stub(:find).with(42).and_return(mock_person)

      get :show, :id => 42

      response.should be_success
      assigns(:person).should == mock_person
    end
  end

  describe "GET 'edit'" do
    it "should load the person from the database" do
      Person.stub(:find).with(42).and_return(mock_person)

      get :edit, :id => 42

      response.should be_success
      assigns(:person).should == mock_person
    end
  end

  describe "PUT 'update'" do
    it "should update person" do
      Person.stub(:find).with(1).and_return(mock_person)
      valid_info = {:id => 1, :person => {"username" => "soulnafein", "email" => "soulnafe@gmail.com", "password" => "test", "password_confirmation" => 'test'}}
      mock_person.should_receive(:update_attributes!).with(valid_info[:person])

      put :update, valid_info

      response.should redirect_to person_url(mock_person)
    end

    it "should go back to form in case of errors" do
      Person.stub(:find).with(1).and_return(mock_person_with_errors)
      mock_person.should_receive(:update_attributes!).and_raise(ActiveRecord::RecordInvalid.new(mock_person_with_errors))
      invalid_info = {:id => 1, :person => {"username" => "soulnafein", "email" => "soulnafe@gmail.com.", "password" => "test", "password_confirmation" => 'testsss'}}

      put :update, invalid_info

      response.should render_template(:edit)
    end
  end

  describe "GET 'new" do
    it "should provide an empty person to the page" do
      get :new

      response.should be_success
      assigns(:person).should_not be_nil
    end
  end

  describe "POST 'create'" do
    it "should save person" do
      Person.stub(:new).and_return(mock_person)
      mock_person.should_receive(:save!)
      valid_signup = {:person => {:username => "soulnafein", :email => "soulnafe@gmail.com", :password => "test", :password_confirmation => 'test'}}

      post :create, valid_signup

      response.should redirect_to("/pages/invitation_requested")
    end

    it "should go back to form in case of errors" do
      Person.stub(:new).and_return(mock_person_with_errors)
      mock_person.should_receive(:save!).and_raise(ActiveRecord::RecordInvalid.new(mock_person_with_errors))
      invalid_signup = {:person => {:username => "soulnafein", :email => "soulnafe@gmail.com.", :password => "test", :password_confirmation => 'testsss'}}

      post :create, invalid_signup

      response.should render_template(:new)
    end
  end


  def mock_person(stubs={})
    @mock_person ||= mock_model(Person, stubs).as_null_object
  end

  def mock_person_with_errors
    errors = mock("errors")
    mock_person.stub!(:errors).and_return(errors)
    errors.stub!(:full_messages).and_return([])
    @mock_person
  end
end
