require 'spec_helper'

describe 'haproxy_config::global' do
  let(:haproxy_config_path) { File.expand_path('tmp/output') }
  let(:haproxy_config_file) { "#{haproxy_config_path}/haproxy.config" }

  before do
    step_into 'haproxy_config_global'
    chef_run.node.set['haproxy_config']['config_file'] = 'tmp/output/haproxy.config'
  end

  it 'creates nested directories if not existent' do
    expect(File.exists?(haproxy_config_path)).to be_false

    converge_recipe "basic_stuff", %[
      include_recipe 'haproxy_config'
      haproxy_config_global 'stuff' do
        maxconn 6000
      end
    ]

    expect(File.exists?(haproxy_config_path)).to be_true
  end

  it 'creates an haproxy config file based on node attributes' do
    expect(File.exists?(haproxy_config_file)).to be_false

    converge_recipe "basic_stuff", %[
      include_recipe 'haproxy_config'
      haproxy_config_global 'stuff' do
        maxconn 6000
      end
    ]

    expect(File.exists?(haproxy_config_file)).to be_true
  end

  it 'outputs global config into haproxy config' do
    expect {
      converge_recipe "basic_stuff", %[
        include_recipe 'haproxy_config'
        haproxy_config_global 'stuff' do
          maxconn 6000
        end
      ]
    }.to write_haproxy_config('tmp/output/haproxy.config', <<-END, trim: 6)
      global
        maxconn 6000
    END
  end
end
