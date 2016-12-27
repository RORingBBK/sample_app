require 'rails_helper'

describe StaticPagesController do
  render_views

  let(:base_title) { "Sample App" }

  it "should get root" do
    get :home
    expect(response).to be_success
  end

  it "should get help" do
    get :help
    expect(response).to be_success
    assert_select "title", "Help | #{base_title}"
  end

  it "should get about" do
    get :about
    expect(response).to be_success
    assert_select "title", "About | #{base_title}"
  end

  it "should get contact" do
    get :contact
    expect(response).to be_success
    assert_select "title", "Contact | #{base_title}" 
  end

end