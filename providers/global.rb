require 'fileutils'

action :create do
  global_section = ::HaproxyConfigGlobal.new
  global_section.update_with_resource(new_resource)
  HaproxyConfig.instance.sections << global_section
end
