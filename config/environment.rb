# Load the rails application
require File.expand_path('../application', __FILE__)

Thingspeak::Application.configure do
	config.action_controller.perform_caching = true
	config.cache_store = :dalli_store, { :compress => true, :value_max_bytes => 5120 * 1024 }

	config.action_mailer.delivery_method = :smtp
	config.action_mailer.smtp_settings = {
		:enable_starttls_auto => true,
		:address => 'smtp.gmail.com',
		:port => 587,
		:domain => '',
		:authentication => :plain,
		:user_name => '',
		:password => ''
	}
end

# Initialize the rails application
Thingspeak::Application.initialize!

# dalli settings
if defined?(PhusionPassenger)
  PhusionPassenger.on_event(:starting_worker_process) do |forked|
    # Only works with DalliStore
    Rails.cache.reset if forked
  end
end