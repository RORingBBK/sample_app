require 'rails_helper'

describe Micropost do
  fixtures :microposts, :users

  let(:user) { users(:michael) }
  let(:micropost) { user.microposts.build(content: "Sample test") }

  it "should be valid" do
    expect(micropost.valid?).to be true
  end

  it "should have user id" do
    micropost.user_id = nil
    expect(micropost.valid?).to be false
  end

  it "should have content" do
    micropost.content = "  "
    expect(micropost.valid?).to be false
  end

  it "should have content with at most 140 characters" do
    micropost.content = "a" * 141
    expect(micropost.valid?).to be false
  end

  it "should have content in order with most recent first" do
    expect(microposts(:most_recent)).to eq(Micropost.first)
  end

end
