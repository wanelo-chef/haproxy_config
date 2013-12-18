require 'fileutils'

def load_current_resource
  @current_resource = Chef::Resource::HaproxyConfigGlobal.new(new_resource.name)
  begin
    new_resource.file_resource = run_context.resource_collection.find(:haproxy_config_file => 'stuff')
  rescue Chef::Exceptions::ResourceNotFound
  end
end

action :create do
  unless new_resource.file_resource
    new_resource.file_resource = haproxy_config_file node['haproxy_config']['config_file']
  end

  global_section = ::HaproxyConfigGlobal.new
  global_section.update_with_resource(new_resource)
  HaproxyConfig.instance.sections << global_section

  new_resource.notifies(:write, new_resource.file_resource, :delayed)
end
