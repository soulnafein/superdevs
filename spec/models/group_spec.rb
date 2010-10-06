require 'spec_helper'

describe Group do
  it "should include the organizer in the members list" do
    organizer = mock_model(User)
    group = Group.new do |g|
      g.organizer = organizer
    end

    group.members.should include organizer
  end

  it "should tell me whether a user is the organizer of the group" do
    david_santoro = mock_model(User)
    ken_fassone = mock_model(User)

    group = Group.new do |g|
      g.organizer = david_santoro
    end

    group.organizer?(david_santoro).should be_true
    group.organizer?(ken_fassone).should be_false
    group.organizer?(nil).should be_false
  end

  it "should have many members with the organizer" do 
    group = Group.new
    group.members.size.should == 1
  end

  it "should tell me if an user is member of the group" do 

  end
end
