require 'spec_helper'

describe Group do
  it "should include the organizer in the members list" do
    organizer = mock_model(User)
    group = Group.new(:organizer => organizer)

    group.members.should include organizer
  end
end
