require 'rails_helper'

describe MicropostsController do
  fixtures :microposts, :users

  let(:micropost) { microposts(:orange) }

  describe 'should redirect' do
    it "create when logged in" do
      expect { post :create, params: { micropost: { content: "Happy Monday folks" } } }.to_not change { Micropost.count }
      response.should redirect_to login_url
    end

    it "destroy when not logged in" do
      expect { delete :destroy, id: micropost }.to_not change{ Micropost.count }
      response.should redirect_to login_url
    end

    it "destroy for wrong micropost" do
      log_in_as(users(:michael))
      micropost = microposts(:ants)
      expect { delete :destroy, id: micropost }.to_not change{ Micropost.count }
    end
  end
end
