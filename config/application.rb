require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"

# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RriStaffing
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    config.assets.paths << Rails.root.join("app", "assets", "fonts")
    config.autoload_paths << Rails.root.join('lib')
    config.generators.javascript_engine = :js
    I18n.default_locale = :en
    I18n.available_locales = [:en]
    config.i18n.fallbacks = [I18n.default_locale]
    config.active_job.queue_adapter = :delayed_job
    # Don't generate system test files.
    config.generators.system_tests = nil
  end
end
