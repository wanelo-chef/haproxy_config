RSpec::Matchers.define :write_haproxy_config do |file_path, expected_config, options|
  match do |recipe|
    @file_path = file_path
    @expected_config = expected_config
    @options = {
        trim: 0
    }.merge(options)

    @recipe = recipe.call
    found_config_content == expected_config_content
  end

  failure_message_for_should do |recipe|
    "expected that recipe would write haproxy config:\n#{expected_config_content}\nbut wrote:\n#{found_config_content}"
  end

  description do
    "write haproxy config:\n#{expected_config_content}"
  end

  def found_config_content
    if File.file?(@file_path)
      File.read(@file_path)
    else
      'no file found'
    end
  end

  def expected_config_content
    @expected_config.gsub(/^\s{#{@options[:trim]}}/, '')
  end
end
