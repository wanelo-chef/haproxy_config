require 'spec_helper'

describe 'haproxy_config::global' do
  before { step_into 'haproxy_config_global' }

  it 'adds a config instance to HaproxyConfig sections' do
    expect {
      converge_recipe "global", %[
        include_recipe 'haproxy_config'
        haproxy_config_global 'stuff' do
          maxconn 6000
        end
      ]
    }.to change {
      HaproxyConfig.instance.sections.first
    }.from(nil).to(an_instance_of(HaproxyConfigGlobal))
  end

  it 'updates config instance with new_resource' do
    converge_recipe "global", %[
      include_recipe 'haproxy_config'
      haproxy_config_global 'stuff' do
        maxconn 6000
        nbproc 2
        user 'somebody'
      end
    ]

    global_config = HaproxyConfig.instance.sections.first
    expect(global_config.maxconn).to eq(6000)
    expect(global_config.nbproc).to eq(2)
    expect(global_config.user).to eq('somebody')
  end

  it 'notifies haproxy_config_file' do
    chef_run.node.set['haproxy_config']['config_file'] = '/path/to/haproxy.conf'

    converge_recipe "global", %[
      include_recipe 'haproxy_config'
      haproxy_config_global 'stuff'
    ]

    global_resource = chef_run.run_context.resource_collection.find(:haproxy_config_global => 'stuff')
    expect(global_resource).to notify('haproxy_config_file[/path/to/haproxy.conf]').to(:write)
  end
end
