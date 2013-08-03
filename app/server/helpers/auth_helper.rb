module Translations
  module AuthHelper
    def current_user
      @current_user ||= User.find_by_email(session[:user_id])
    end

    def authenticated?
      current_user.present?
    end

    def authenticate!
      halt 401, {error: 'Not Authenticated'} unless authenticated?
    end
  end
end
