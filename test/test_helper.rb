ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/reporters'
Minitest::Reporters.use!


class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  include ApplicationHelper

  # Returns true if a test user is logged in.
  def is_logged_in?
    !session[:user_id].nil?
  end

#   # Log in a particular user.
#   def log_in_as(user, options={})
#     password = options[:password] || 'nepal123'
#     session[:user_id] = user.id
#   end
# end

# class ActionDispatch::IntegrationTest

#   # Log in as a particular user.
#   def log_in_as(user, password: 'password', remember_me: '1')
#     post login_path, params: { session: { email: user.email,
#                                           password: password,
#                                           remember_me: remember_me } }    
#   end

  # Logs in a test user.
  def log_in_as(user, options = {})
    password    = options[:password]    || 'password'
    remember_me = options[:remember_me] || '1'
    if integration_test?
      post login_path, session: { email:       user.email,
                                  password:    password,
                                  remember_me: remember_me }
    else
      session[:user_id] = user.id
    end
  end
  
  private
  
    # Returns true inside an integration test.
    def integration_test?
      defined?(post_via_redirect)
    end

end
