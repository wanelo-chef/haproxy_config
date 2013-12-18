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
    FileUtils.mkdir_p("#{cookbook_path}/fixtures/recipes")
    File.open("#{cookbook_path}/fixtures/metadata.rb", 'w') do |md|
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
    File.open("#{cookbook_path}/fixtures/recipes/#{recipe_name}.rb", 'w+') do |f|
      f.puts recipe_code
    end
    runner.converge "fixtures::#{recipe_name}"
    recipe_code
  end

  def runner
    @runner ||= ChefSpec::Runner.new(
      step_into: runner_options[:step_into],
      cookbook_path: %W(#{cookbook_path} #{File.expand_path("..", Dir.pwd)})
    )
  end

  def cookbook_path
    RSpec.configuration.cookbook_path
  end

  def step_into *lwrps
    runner_options[:step_into] ||= []
    runner_options[:step_into].concat(lwrps)
  end
end
