require 'spec_helper'

describe CodeSnippetsController, "Adding a new code snippet" do
  include SessionTestHelper

  before :each do
    @david = Factory.build(:david, :id => 1)
  end

  context "When posting valid details for a code snippet" do
    it "should save the code snippet and redirect to the code snippets page" do
      logged_in_user_is @david

      valid_details = {'code_snippet' =>
                         {'code' => 'Some kind of code',
                          'language' => 'js',
                          'title' => 'A code snippet',
                          'description' => 'Some kind of description'}
                      }

      post :create, valid_details

      response.should redirect_to code_snippets_url
      CodeSnippet.count.should == 1
      CodeSnippet.first.author.should == @david
    end
  end

  context "When posting invalid details" do
    it "should go back to the form" do
      logged_in_user_is @david
      wrong_details = {'code_snippet' =>
                               {'code' => '',
                                'title' => '',
                                'language' => '',
                                'description' => ''}
      }

      post :create, wrong_details

      response.should render_template('posts/new')
      assigns(:code_snippet).errors.any?.should be_true
      assigns(:link).should_not be_nil
    end
  end
end