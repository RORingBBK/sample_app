require 'rails_helper'

describe UsersController do
  fixtures :users
  render_views

  let(:user) { users(:michael) }
  let(:other_user) { users(:archer) }

  it "should redirect index when not logged in" do
    get :index
    response.should redirect_to login_url
  end

  it "should get new" do
    get :new
    expect(response).to be_success
    assert_select "title", "Sign Up | Sample App"
  end

  it "should redirect edit when not logged in" do
    get :edit, id: user
    expect(flash.empty?).to be false
    response.should redirect_to login_url
  end

  it "should redirect update when not logged in" do
    patch :update, id: user, user: { name: user.name,
                                     email: user.email }
    expect(flash.empty?).to be false
    response.should redirect_to login_url
  end

  it "should redirect destroy when not logged in" do
    expect { delete :destroy, id: user }.to_not change{ User.count }
    response.should redirect_to login_url
  end

  it "should redirect destroy when logged in as a non-admin" do
    log_in_as(other_user)
    expect { delete :destroy, id: user }.to_not change{ User.count }
    response.should redirect_to root_url
  end

end