require 'spec_helper'

describe LinksController, "Visualising a list of links" do
  it "should visualise the links ordered by date" do
    some_links = [Factory.build(:a_link), Factory.build(:another_link)]

    Link.should_receive(:get_latest).and_return(some_links)

    get :index

    assigns(:links).should == some_links
  end
end