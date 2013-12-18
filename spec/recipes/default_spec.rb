require 'spec_helper'

describe 'haproxy_config::default' do
  it 'includes the paths recipe' do
    chef_run = runner.converge('haproxy_config')
    expect(chef_run).to include_recipe('paths')
  end
end
