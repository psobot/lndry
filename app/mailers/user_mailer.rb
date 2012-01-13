class UserMailer < PostageApp::Mailer
  default_url_options[:host] = defined?(HOST) ? HOST : 'localhost:3000'

  def done_reminder_for(user, use)
    postageapp_template 'done'
    mail :to => { user.email => user.email_variables.merge(use ? use.email_variables : {}) }, :subject => ''
  end

  def available_reminder_for(user, resource)
    postageapp_template 'available'
    mail :to => { user.email => user.email_variables.merge(resource ? resource.email_variables : {}) }, :subject => ''
  end

end
