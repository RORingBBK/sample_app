require 'rails_helper'

describe "PasswordResets" do
  fixtures :users

    let (:user) { users(:michael) }

    it "emails user for password reset" do
      visit login_path
      click_link "forgot password"
      fill_in "Email", :with => user.email
      click_button "Submit"
      current_path.should eq(root_path)
      page.should have_content("Email sent with password reset instructions")
      expect(ActionMailer::Base.deliveries.size).to eq(1)
    end
end
