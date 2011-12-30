class UserMailer < PostageApp::Mailer
  default from: "mailer@lndry.com"
  default_url_options[:host] = defined?(HOST) ? HOST : 'localhost:3000'

  def done_reminder_for(user)
    postageapp_template 'done'
    mail :to => { user.email => { :name => user.email } }, :subject => ''
  end

  def available_reminder_for(user)
    postageapp_template 'available'
    mail :to => { user.email => { :name => user.email } }, :subject => ''
  end


end
