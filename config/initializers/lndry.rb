settings_file = File.expand_path('../settings.yml', File.dirname(__FILE__))
settings = YAML::load(File.open(settings_file))
env = Rails.env

PostageApp.configure do |config|
  config.api_key = '7uQSpPxWGKHp8vfkWt5D7o0tErsphRcg'
  config.recipient_override = settings[env]['recipient_override']
end

HOST = settings[env]['host']
