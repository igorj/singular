require 'minitest/autorun'
require 'minitest/reporters'

Dir.glob("#{File.expand_path(File.dirname(__FILE__))}/../../app/server/models/*.rb").each { |file| require file }

class MiniTest::Spec
  def ppjson (obj)
    puts JSON.pretty_generate(JSON.parse(obj.to_json))
  end
end

if ENV['RM_INFO'] || ENV['TEAMCITY_VERSION']
  MiniTest::Reporters.use! MiniTest::Reporters::RubyMineReporter
end

ENV['RACK_ENV'] = 'test'
Mongoid.load!(File.join(File.dirname(__FILE__), '../../app/server/mongoid.yml'))

