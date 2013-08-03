require 'minitest/spec'
require 'minitest/autorun'
require 'minitest/reporters'
require 'capybara'
require 'minitest-capybara'
require 'capybara/poltergeist'
require 'sinatra'
require_relative '../../app/server/server'
require_relative '../../app/server/models/user'


if ENV['RM_INFO'] || ENV['TEAMCITY_VERSION']
  MiniTest::Reporters.use! MiniTest::Reporters::RubyMineReporter
end

ENV['RACK_ENV'] = 'test'
Capybara.app = Singular::App

class MiniTest::Spec
  include Capybara::RSpecMatchers
  include Capybara::DSL

  def setup
    Capybara.current_driver = :selenium
    #Capybara.current_driver = :poltergeist
  end

  def teardown
    Capybara.reset_sessions!
    Capybara.use_default_driver
  end
end


