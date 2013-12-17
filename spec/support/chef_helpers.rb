require 'fileutils'

module ChefHelpers
  def setup_chef(setup = {})
    @cookbook_name = setup[:cookbook_name]
    @checksum_path = Chef::Config[:checksum_path]
    Chef::Config[:checksum_path] = "#{File.expand_path(Dir.pwd)}/tmp/checksums"
  end

  def reset_chef
    Chef::Config[:checksum_path] = @checksum_path
    runner_options.clear
    reset_fixtures
  end

  def runner_options
    @options ||= {}
  end

  def install_fixtures
    FileUtils.mkdir_p('tmp/fixtures/recipes')
    File.open('tmp/fixtures/metadata.rb', 'w') do |md|
      md.puts 'name "fixtures"'
      md.puts 'version "1.0.0"'
      md.puts "depends \"#{@cookbook_name}\""
    end
  end

  def reset_fixtures
    FileUtils.rm_rf('tmp')
  end

  def converge_recipe recipe_name, recipe_code
    install_fixtures
    File.open("tmp/fixtures/recipes/#{recipe_name}.rb", 'w+') do |f|
      f.puts recipe_code
    end
    chef_run.converge "fixtures::#{recipe_name}"
    recipe_code
  end

  def chef_run
    @chef_run ||= ChefSpec::Runner.new(
      platform: 'smartos', version: 'joyent_20130111T180733Z',
      step_into: runner_options[:step_into],
      cookbook_path: %W(#{File.expand_path(Dir.pwd)}/tmp #{File.expand_path("..", Dir.pwd)})
    )
  end

  def step_into *lwrps
    runner_options[:step_into] ||= []
    runner_options[:step_into].concat(lwrps)
  end
end
