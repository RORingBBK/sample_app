require 'rails_helper'

RSpec.describe "UsersIndices", type: :request do
  fixtures :users

  let(:admin) { users(:michael) }
  let(:non_admin) { users(:archer) }

  describe "GET /users_indices" do
    it "should index as admin including pagination and delete links" do
      # log_in_as(admin)
    end
  end
end
