# rails_helper.rb
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'

# Add the following lines to properly configure FactoryBot
require 'factory_bot'
# Ensure that FactoryBot knows where to find your factories
FactoryBot.definition_file_paths = [File.expand_path('../factories', __dir__)]
FactoryBot.find_definitions

# ... (existing configurations)

RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = Rails.root.join('spec/fixtures')
  config.order = 'default'

  # ... (existing configurations)

  Shoulda::Matchers.configure do |shoulda_config|
    shoulda_config.integrate do |with|
      with.test_framework :rspec
      with.library :rails
    end
  end

  config.include FactoryBot::Syntax::Methods
  # Add this line to include view specs
  config.include RSpec::Rails::ViewRendering

  # ... (existing configurations)

  config.use_transactional_fixtures = true

  # ... (existing configurations)

  config.infer_spec_type_from_file_location!

  # ... (existing configurations)

  config.filter_rails_from_backtrace!
end
