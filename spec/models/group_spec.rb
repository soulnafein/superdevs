require 'spec_helper'

describe Group do
  it "should include the organizer in the members organizer list" do
    organizer = mock_model(User)
    group = Group.new do |g|
      g.organizer = organizer
    end

    group.members_organizer.should include organizer
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
    group.members.size.should == 0
  end

  it "should tell me if an user is member of the group" do 
    david_santoro = mock_model(User)
    ken_fassone = mock_model(User)

    group = Group.new do |g|
      g.members.push(ken_fassone)
    end

    group.member?(ken_fassone).should be_true
    group.member?(david_santoro).should be_false
    group.member?(nil).should be_false
  end
end
