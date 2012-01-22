# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
settings_file = File.expand_path('../settings.yml', File.dirname(__FILE__))
settings = YAML::load(File.open(settings_file))
env = Rails.env
Lndry::Application.config.secret_token = settings[env]['secret_token']
