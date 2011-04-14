require 'spec_helper'

describe LinksController, "Adding a new link" do
  include SessionTestHelper

  before :each do
    @david = Factory.build(:david, :id => 1)
  end

  it "should visualise the form for creating links" do
    logged_in_user_is @david
    get :new

    response.should be_success
    assigns(:link).class.should == Link
  end

  context "When posting valid details for a link" do
    it "should save the link and redirect to the links page" do
      logged_in_user_is @david

      valid_details = {'link' =>
                         {'url' => 'http://google.com',
                          'title' => 'A link',
                          'description' => 'Some kind of description'}
                      }

      post :create, valid_details

      response.should redirect_to links_url
      Link.count.should == 1
      Link.first.author.should == @david
    end
  end

  context "When posting invalid details" do
    it "should go back to the form" do
      logged_in_user_is @david
      wrong_details = {'link' =>
                               {'url' => '',
                                'title' => '',
                                'description' => ''}
      }
      post :create, wrong_details

      response.should render_template('new')
      assigns(:link).errors.any?.should be_true
    end
  end
end