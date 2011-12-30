class UserMailer < PostageApp::Mailer
  default from: "mailer@lndry.com"

  def send_available_to user
    logger.debug "<><> SENDING TO #{user.email} <><>"
    mail.deliver
    false
  end

end
