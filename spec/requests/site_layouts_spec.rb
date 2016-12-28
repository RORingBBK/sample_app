require 'rails_helper'

describe "SiteLayouts" do

  describe "GET /site_layouts" do
    subject { get root_path }

    it "checks layout links" do
      expect(subject).to render_template('static_pages/home')
      assert_select "a[href=?]", root_path, count: 2
      assert_select "a[href=?]", help_path
      assert_select "a[href=?]", about_path
      assert_select "a[href=?]", contact_path
      get contact_path
      assert_select "title", full_title("Contact")
    end
  end
end