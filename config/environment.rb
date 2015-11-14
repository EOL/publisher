# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

# Cleaner (and less shout-y) reading from the environment variables:
def env(name, default)
  ENV["EOL_#{name.upcase}"] || default
end

Rails.configuration.site_id = env(:site_id, 1)
Rails.configuration.users_resource_id = env(:users_resource_id, 1)
