# encoding: utf-8
require 'sinatra/base'
require 'mongoid'
require 'rabl'
require 'i18n'

Dir.glob("#{File.expand_path(File.dirname(__FILE__))}/{helpers,models}/*.rb").each { |file| require file }

module Singular
  class App < Sinatra::Base
    include Translations::AuthHelper
    include Translations::JsonHelper

    # ========================= CONFIGURATION ====================

    configure do
      set :show_exceptions, false
      set :views, File.join(File.dirname(__FILE__), 'views')
      set :session_secret, ENV['SESSION_SECRET'] || 'devSecret'
      use Rack::Session::Cookie, :key => '_rack_session', :path => '/', :expire_after => 1200, :secret => settings.session_secret
      Mongoid.load!(File.join(File.dirname(__FILE__), 'mongoid.yml'))
      I18n.load_path += Dir[File.join(File.dirname(__FILE__), 'locales', '*.yml').to_s]

      Rabl.configure do |config|
        config.include_json_root = false
        config.include_child_root = false
        if production?
          config.cache_sources = true
          config.cache_all_output = true
        end
      end
      set :rabl, views: File.join(File.dirname(__FILE__), 'views/json')
    end

    configure :development do
      require 'sinatra/reloader'
      require 'rack-livereload'
      set :public_folder, (ENV['PUBLIC_FOLDER'] or File.join(File.dirname(__FILE__), '../../public'))
      set :index_erb, (ENV['INDEX_ERB'] or :index)
      use Rack::LiveReload
    end

    configure :production do
      require 'rack/ssl-enforcer'
      require 'newrelic_rpm'
      set :public_folder, File.join(File.dirname(__FILE__), '../../dist')
      set :index_erb, :'generated/index_production'
      use Rack::SslEnforcer
    end


    # ========================= COMMON URLS AND REDIRECTS ==============================

    ['/', '/home', '/login', '/users'].each do |route|
      get route do
        # Redirect for Angular.js page reload: Send index.erb and let angular do the routing
        erb settings.index_erb.to_sym, locals: {current_user: current_user}
      end
    end

    get '/users/:id' do
      redirect "/users"
    end

    error Mongoid::Errors::Validations do |e|
      all_errors = e.document.errors.full_messages.compact
      halt 400, "Validation error: #{all_errors.join(', ')}"
    end

    error do |e|
      halt 500, "Technical error: #{e.message}"
    end

    not_found do
      "Page you are trying to open doesn't exist."
    end


    # ========================= LOGIN API =========================

    post '/api/login' do
      @user = User.authenticate(json_data['email'], json_data['password'])
      if @user
        session[:user_id] = @user.email
        rabl :user
      else
        session[:user_id] = nil
        halt 400, 'Login error! Check your email or password.'
      end
    end

    delete '/api/logout' do
      puts "Logout user: #{current_user}"
      session.clear
    end


    # ========================= USERS API =========================

    get '/api/users' do
      authenticate!
      @users = User.all
      rabl :users
    end

    get '/api/users/:id' do
      authenticate!
      @user = User.find(params[:id])
      halt 404, 'User not found' unless @user
      rabl :user
    end

    post '/api/users' do
      authenticate!
      @user = User.create_user json_data['name'], json_data['email'], json_data['password']
      rabl :user
    end

    post '/api/users/:id' do
      authenticate!
      user = User.find(params[:id])
      @user = user.update_with(json_data)
    end

    delete '/api/users/:id' do
      authenticate!
      user = User.find(params[:id])
      success = user.destroy
      halt 500, 'Cannot delete user' unless success
    end
  end
end

