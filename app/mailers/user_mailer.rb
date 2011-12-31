class UserMailer < PostageApp::Mailer
  default_url_options[:host] = defined?(HOST) ? HOST : 'localhost:3000'

  def done_reminder_for(user)
    postageapp_template 'done'
    mail :to => { user.email => user.email_variables }, :subject => ''
  end

  def available_reminder_for(user)
    postageapp_template 'available'
    mail :to => { user.email => user.email_variables }, :subject => ''
  end

end
