begin
    settings_file = File.expand_path('../settings.yml', File.dirname(__FILE__))
    settings = YAML::load(File.open(settings_file))
    env = Rails.env

    PostageApp.configure do |config|
      config.api_key = settings[env]['postageapp_api_key']
      config.recipient_override = settings[env]['recipient_override']
    end

    HOST = settings[env]['host']
    INCOMING_EMAIL_KEY = settings[env]['incoming_email_key']
rescue Errno::ENOENT
    env = Rails.env

    PostageApp.configure do |config|
      config.api_key = ENV['postageapp_api_key']
      config.recipient_override = ENV['recipient_override']
    end

    HOST = ENV['host']
    INCOMING_EMAIL_KEY = ENV['incoming_email_key']
end