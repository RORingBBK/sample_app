require 'rails_helper'

describe RelationshipsController do
  fixtures :relationships

  context "should require logged-in" do
    it "for create" do
      expect { post :create }.to_not change{ Relationship.count }
      response.should redirect_to login_url
    end

    it "for destroy" do
      expect{ delete :destroy, id: relationships(:one) }.to_not change{ Relationship.count }
      response.should redirect_to login_url
    end
  end

end