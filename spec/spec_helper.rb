# frozen_string_literal: true

require 'pry' unless ENV['CI']

begin
  gem 'psych', '< 4'
  require 'psych'
rescue Gem::LoadError
end

require 'active_record'
require 'mysql2'
require 'store_attribute'

connection_params =
  if ENV.key?('DATABASE_URL')
    {'url' => ENV['DATABASE_URL']}
  else
    {
      'host' => ENV['DB_HOST'],
      'username' => ENV.fetch('DB_USER', 'root')
    }
  end

ActiveRecord::Base.establish_connection(
  {
    'adapter' => 'mysql2',
    'database' => 'store_attribute_test'
  }.merge(connection_params)
)

connection = ActiveRecord::Base.connection
connection.reconnect!

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].sort.each { |f| require f }

RSpec.configure do |config|
  config.mock_with :rspec

  config.filter_run_when_matching :focus

  config.example_status_persistence_file_path = 'tmp/rspec_examples.txt'

  if config.files_to_run.one?
    config.default_formatter = 'doc'
  end
end
