require 'spec_helper'

describe 'haproxy_config::file' do
  let(:haproxy_config_path) { File.expand_path('tmp/output') }
  let(:haproxy_config_file) { "#{haproxy_config_path}/haproxy.conf"}

  before { step_into 'haproxy_config_file' }

  describe 'action :write' do
    it 'creates nested directories if not existent' do
      expect(File.directory?(haproxy_config_path)).to be false

      converge_recipe "file", %[
        include_recipe 'haproxy_config'
        haproxy_config_file '#{haproxy_config_file}' do
          action :write
        end
      ]

      expect(File.directory?(haproxy_config_path)).to be true
    end

    it 'creates an haproxy config file resource name' do
      expect(File.file?(haproxy_config_file)).to be false

      converge_recipe "file", %[
        include_recipe 'haproxy_config'
          haproxy_config_file '#{haproxy_config_file}' do
            action :write
          end
      ]

      expect(File.file?(haproxy_config_file)).to be true
    end

    it 'outputs HaproxyConfig into haproxy config' do
      expect {
        converge_recipe "file", %[
          HaproxyConfig.instance.sections << 'haproxy configuration'

          include_recipe 'haproxy_config'
          haproxy_config_file '#{haproxy_config_file}' do
            action :write
          end
        ]
      }.to write_haproxy_config(haproxy_config_file, <<-END, trim: 8)
        haproxy configuration
      END
    end
  end
end
