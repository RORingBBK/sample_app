require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "Bibek Khadka", email: "sample@test.com",
                     password: "sampletest", password_confirmation: "sampletest")
  end

  test "should be valid" do 
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = ' '
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = ' '
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 250 + "@test.com"
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[sample@test.com SAMPLE@tesT.com S_A_M@test.bar.org 
                         sample.new@test.com sample+test@test.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid."
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[sample@test,com sample_test.com sample.name@@test.com
                           sample@test+new.com sample@test..com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save # For uniqueness test put record into database.
    assert_not duplicate_user.valid?
  end

  test "email should be downcase before writing in database" do
    mixed_case_email = "SaMPLE@teST.com"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "password should not be blank" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minumum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "authenticated? should return false with user with nil digest" do
    assert_not @user.authenticated?('')
  end
end
