Rails.application.config.generators do |g|
  g.test_framework      :rspec,
                        fixture: false,
                        view_specs: false,
                        controller_specs: true,
                        helper_specs: false,
                        routing_specs: false
  g.integration_tool    true
  g.stylesheets         false
  g.javascripts         false
  g.decorator           false
  g.helper              false
  g.fixture_replacement :factory_bot, dir: 'spec/factories'
  # g.template_engine     :haml
  # g.fallbacks[:haml] = :erb
end
