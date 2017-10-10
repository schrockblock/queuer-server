ENV['RAILS_ENV'] = 'test'

require File.expand_path('../../config/environment', __FILE__)

# require 'paperclip/matchers'
require 'rspec/rails'
require 'shoulda/matchers'
# require 'paper_trail/frameworks/rspec'

Dir[Rails.root.join('spec/support/**/*.rb')].sort.each { |file| require file }

module Features
  # Extend this module in spec/support/features/*.rb
  include Formulaic::Dsl
end

RSpec.configure do |config|
  config.include(Shoulda::Matchers::ActiveModel, type: :model)
  config.include(Shoulda::Matchers::ActiveRecord, type: :model)
  config.include ExternalRequests
  config.include Features, type: :feature
  config.include Helpers::Requests, type: :request
  config.include Helpers::Requests, type: :routing
  config.include JsonSpec::Helpers
  # config.include Paperclip::Shoulda::Matchers
  config.infer_base_class_for_anonymous_controllers = false
  config.infer_spec_type_from_file_location!
  config.use_transactional_fixtures = false

  if Bullet.enable?
    config.before(:each) do
      Bullet.start_request
    end

    config.after(:each) do
      Bullet.perform_out_of_channel_notifications if Bullet.notification?
      Bullet.end_request
    end
  end
end

ActiveRecord::Migration.maintain_test_schema!
Capybara.javascript_driver = :webkit
