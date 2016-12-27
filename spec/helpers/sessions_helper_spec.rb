require 'rails_helper'

describe SessionsHelper do
  fixtures :users

  let(:user) { users(:michael) }

  context 'current user' do
    before  do
      remember(user)
    end

    it "should return right user when session is nil" do
      expect(user).to eq(current_user)
      expect(is_logged_in?).to be true
    end

    it "should return nil when remember digest is wrong" do
      user.update_attribute(:remember_digest, User.digest(User.new_token))
      expect(current_user).to be nil
    end

  end

end