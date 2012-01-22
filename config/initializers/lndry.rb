settings_file = File.expand_path('../settings.yml', File.dirname(__FILE__))
settings = YAML::load(File.open(settings_file))
env = Rails.env

PostageApp.configure do |config|
  config.api_key = settings[env]['postageapp_api_key']
  config.recipient_override = settings[env]['recipient_override']
end

HOST = settings[env]['host']
INCOMING_EMAIL_KEY = settings[env]['incoming_email_key']
