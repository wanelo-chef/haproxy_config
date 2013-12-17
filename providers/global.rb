
require 'fileutils'

action :create do
  ::FileUtils.mkdir_p(::File.dirname(node['haproxy_config']['config_file']))

  ::File.open(node['haproxy_config']['config_file'], 'w') do |f|
    f.puts 'global'
    f.puts "  maxconn #{new_resource.maxconn}"
  end
end
