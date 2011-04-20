require 'spec_helper'

describe CodeSnippetsController, "Visualising a list of code snippets" do
  it "should visualise the code snippets ordered by date" do
    some_links = [Factory.build(:a_code_snippet), Factory.build(:another_code_snippet)]

    CodeSnippet.should_receive(:get_latest).and_return(some_links)

    get :index

    assigns(:code_snippets).should == some_links
  end
end