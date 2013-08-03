# Run all ruby unit tests
Dir.chdir File.dirname(__FILE__)
Dir.glob '**/*_spec.rb' do |file|
  require_relative file
end