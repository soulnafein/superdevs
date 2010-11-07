require 'spec_helper'

describe "FriendlyForwardings" do
  it "should forward to the requested page after signin" do
    user = Factory(:user)
    visit edit_user_path(user) 
    current_path.should == login_path
    # The test automatically follows the redirect to the signin page.
    fill_in 'user_session_username', :with => user.email
    fill_in 'user_session_password', :with => user.password
    click_button 'user_session_submit'
    current_path.should == edit_user_path(user)
  end

  it "should forward to the event page ater signout and login from event attend" do
    event = Factory(:event)
    visit event_url(event)
    click_link 'Attend this event'
    user = Factory(:user)
    fill_in 'user_session_username', :with => user.email
    fill_in 'user_session_password', :with => user.password
    click_button 'user_session_submit'
    current_path.should == event_path(event)
  end
end

