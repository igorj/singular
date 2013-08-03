# Run all ruby unit tests
Dir.chdir File.dirname(__FILE__)
Dir.glob('**/*_spec.rb') { |file| require_relative file }