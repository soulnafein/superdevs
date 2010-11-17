class Notifier < ActionMailer::Base
  def activation_instructions(user)
    subject       "Activation Instructions"
    from          "noreply@superdevs.com"
    recipients    user.email
    sent_on       Time.now
    body          :account_activation_url => activate_url(user.perishable_token)
  end

  def welcome(user)
    subject       "Welcome to the SuperDevs!"
    from          "noreply@superdevs.com"
    recipients    user.email
    sent_on       Time.now
    body          :root_url => root_url
  end

  def password_reset_instructions(user)
    subject       "Password Reset Instructions"
    from          "noreply@superdevs.com"
    recipients    user.email
    sent_on       Time.now
    body          :edit_password_reset_url => edit_password_reset_url(user.perishable_token)
  end

  def new_follower_notification(user, follower)
    subject       "#{follower.full_name} is now following you on SuperDevs!"
    from          "noreply-notifications@superdevs.com"
    recipients    user.email
    sent_on       Time.now
    body          :follower => follower, :user => user
    content_type  "text/html"
  end

  def week_event_notification(user ,event)
    @user, @event = user, event
    subject       "Reminder: \"#{event.title}\" is next week"
    from          "noreply-notifications@superdevs.com"
    recipients    user.email
    sent_on       Time.now
    content_type  "text/html"
  end
end
