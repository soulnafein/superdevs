require 'spec_helper'

describe Group do
  it "should include the organizer in the members list" do
    organizer = mock_model(User)
    group = Group.new do |g|
      g.organizer = organizer
    end

    group.members.should include organizer
  end
end
