
require File.join(Rails.root,'lib','openshift_secret_generator.rb')
# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.

# Set token based on intialize_secret function (defined in initializers/secret_generator.rb)
RailsApp::Application.config.secret_key_base = initialize_secret(
  :token,
  '7690ad61aa2d4858f71d21f0fd93b0ecbb9c3eb69368f4a467270175a728d8e24c9ee4a7828a7a4edf7c03d64e1797e551ace382d275b6ee8cefbcfb74965ffb'
)
