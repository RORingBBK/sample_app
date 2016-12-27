require 'rails_helper'

describe UserMailer do

  let(:user) { User.create(name: "Bibek", email: "test@sample.com",
                           password: "password", password_confirmation: "password") }
  
  context '#account_activation' do
    subject { UserMailer.account_activation(user) }

    # its(:to) { should include(user.email) }
    # its(:subject) { should == "Account activation" }
    it "should test account activation mail" do
      expect(subject.subject).to eq("Account activation")
      expect(subject.to).to include(user.email) 
      expect(subject.from).to eq(["noreply@example.com"])
      expect(subject.body.encoded).to match(user.name)
      expect(subject.body.encoded).to match(user.activation_token)
      expect(subject.body.encoded).to match(CGI.escape(user.email))
    end
  end

  context '#password_reset' do
    before do
      user.reset_token = User.new_token
    end

    subject { UserMailer.password_reset(user) }

    it "should test password reset mail" do
      expect(subject.subject).to eq("Password reset")
      expect(subject.to).to include(user.email)
      expect(subject.from).to eq(["noreply@example.com"])
      expect(subject.body.encoded).to match(user.reset_token)
      expect(subject.body.encoded).to match(CGI.escape(user.email))
    end
  end

end