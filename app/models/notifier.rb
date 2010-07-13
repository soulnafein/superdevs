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
end