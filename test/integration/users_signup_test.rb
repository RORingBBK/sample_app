require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invavlid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name: "",
                                         email: "user@invalid",
                                         password: "test",
                                         password_confirmation: "sample" } }
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
  end

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count' do
      post users_path, params: { user: { name: "Sample Test",
                                         email: "sample@test.com",
                                         password: "nepal123",
                                         password_confirmation: "nepal123" } }
    end
    follow_redirect!
    assert_template 'users/show'
    assert_not flash.empty?
  end

end
