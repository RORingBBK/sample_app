require 'rails_helper'

describe "UsersSignups" do
  describe "GET /users_signups" do

    before do
      visit signup_path
    end

    it "should show error for invalid signup information" do
      fill_in "Name", :with => ""
      fill_in "Email", :with => "user@invalid.com"
      fill_in "Password", :with => "foo"
      fill_in "Confirmation", :with => "bar"
      click_button "Create my Account"
      current_path.should eq(users_path)
      find(:css, 'div#error_explanation')
    end

  end
end
