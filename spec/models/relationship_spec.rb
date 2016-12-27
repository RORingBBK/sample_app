require 'rails_helper'

describe Relationship do

  let(:relationship) { Relationship.new(follower_id: 1, followed_id: 2) }

  it "should be valid" do
    # expect(relationship.valid?).to be true => (look later)
  end

  it "should require a follower_id" do
    relationship.follower_id = nil
    expect(relationship.valid?).to be false
  end

  it "should require a followed_id" do
    relationship.followed_id = nil
    expect(relationship.valid?).to be false
  end

end