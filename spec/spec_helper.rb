require 'bundler/setup'
require 'chefspec'
require 'chefspec/berkshelf'
require 'pry'

Dir["#{File.dirname(__FILE__)}/../libraries/**/*.rb"].each { |f| require f unless /_spec\.rb$/.match(f) }

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f unless /_spec\.rb$/.match(f) }

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = 'random'

  config.include ChefHelpers

  config.before :each do
    setup_chef cookbook_name: 'haproxy_config'
  end

  config.after :each do
    reset_chef
    HaproxyConfig.instance.reset
  end
end
