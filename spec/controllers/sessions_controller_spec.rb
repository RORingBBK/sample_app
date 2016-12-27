require 'rails_helper'

describe SessionsController do

  it "should get new" do
    get :new
    expect(response).to be_success
  end

end