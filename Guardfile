# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard :rspec do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^libraries/.+\.rb}) { 'spec' }
  watch(%r{^providers/.+\.rb}) { 'spec' }
  watch(%r{^resources/.+\.rb}) { 'spec' }
  watch('spec/spec_helper.rb')  { 'spec' }
end

guard :bundler do
  watch('Gemfile')
end
