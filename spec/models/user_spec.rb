require 'rails_helper'

describe User do
  let(:user) { User.new(name: "Example User", email: "user@example.com",
                        password: "foobar", password_confirmation: "foobar") }

  it "should be valid" do
    user.should be_valid
  end

  it "name should be present" do
    user.name = "  "
    user.should_not be_valid
  end

  it "email should be present" do
    user.email = " "
    user.should_not be_valid 
  end

  it "name should not be too long" do
    user.name = "a" * 51
    user.should_not be_valid
  end
  
end