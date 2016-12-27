require 'rails_helper'

describe User do
  fixtures :users

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

  it "email should not be too long" do
    user.email = "a" * 244 + "@example.org"
    user.should_not be_valid
  end

  it "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      user.email = valid_address
      expect(user.valid?).to be true
    end
  end

  it "should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      user.email = invalid_address
      expect(user.valid?).to be false
    end
  end

  it "should contain unique email address" do
    duplicate_user = user.dup
    duplicate_user.email = user.email.upcase
    user.save
    expect(duplicate_user.valid?).to be false
  end

  context "check for password" do
    it "should not be blank" do
      user.password = user.password_confirmation = "  " * 6
      expect(user.valid?).to be false
    end

    it "should have minumum length" do
      user.password = user.password_confirmation = "a" * 5
      expect(user.valid?).to be false
    end
  end



  it "should return authenticated? with false for a user with nil digest" do
    expect(user.authenticated?(:remember, '')).to be false
  end

  it "should destroy associated microposts" do
    user.save
    user.microposts.create!(content: "Lorem ipsum")
    expect{ user.destroy }.to change { Micropost.count }.by(-1)
  end

  it "should follow and unfollow a user" do
    michael = users(:michael)
    archer = users(:archer)
    expect(michael.following?(archer)).to be false
    michael.follow(archer)
    expect(michael.following?(archer)).to be true
    expect(archer.followers.include?(michael)).to be true
    michael.unfollow(archer)
    expect(michael.following?(archer)).to be false
  end

  it "should have feed with right post" do
    michael = users(:michael)
    archer = users(:archer)
    lana = users(:lana)
    lana.microposts.each do |post_following|
      expect(michael.feed.include?(post_following)).to be true
    end
    michael.microposts.each do |post_self|
      expect(michael.feed.include?(post_self)).to be true
    end
    archer.microposts.each do |post_unfollowed|
      expect(michael.feed.include?(post_unfollowed)).to be false
    end
  end
  
end