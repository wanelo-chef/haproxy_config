require 'spec_helper'

describe 'default attributes' do
  describe 'config_file' do
    it 'is etc dir / haproxy.cfg' do
      runner.node.set['paths']['etc_dir'] = '/path/to/etc'
      runner.converge('haproxy_config::default')
      expect(runner.node['haproxy_config']['config_file']).
        to eq('/path/to/etc/haproxy.cfg')
    end
  end
end
