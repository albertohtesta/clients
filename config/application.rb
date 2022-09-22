# frozen_string_literal: true

require_relative "boot"
require "rails/all"

Bundler.require(*Rails.groups)

module CoreBackend
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    config.active_record.use_yaml_unsafe_load = true

    config.api_only = true

    config.sneakers = config_for(:sneakers)

    config.action_mailer.preview_path = "#{Rails.root}/spec/mailers/previews"
  end
end
