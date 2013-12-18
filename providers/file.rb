require 'fileutils'

action :write do
  ::FileUtils.mkdir_p(::File.dirname(new_resource.name))

  ::File.open(new_resource.name, 'w') do |f|
    f.puts HaproxyConfig.instance.to_s
  end
end
