# encoding: utf-8
require 'mongoid'
require_relative 'models/user'

Mongoid.load!(File.join(File.dirname(__FILE__), 'mongoid.yml'))
User.create_user('Administrator', 'admin@mailinator.com', 'secret', true)