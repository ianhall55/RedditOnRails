require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) do
    FactoryGirl.build(:user,
      username: "mike",
      password: "password")
  end


  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_length_of(:password).is_at_least(8) }

  it { should have_many(:subs) }
  # it { should have_many(:comments) }
  # it { should have_many(:user_votes) }

  it "create a password_digest when valid password is given" do
    expect(user.password_digest).to_not be_nil
  end

  it "creates a session_token before validation" do
    user.valid?
    expect(user.session_token).to_not be_nil
  end

  describe "#is_password?" do
    it "verifies a password is correct" do
      expect(user.is_password?("password")).to be true
    end

    it "verifies a password is not correct" do
      expect(user.is_password?("bad_password")).to be false
    end
  end

  describe ".find_by_credentials" do
    before { user.save! }

    it "returns user given good credentials" do
      expect( User.find_by_credentials("mike", "password")).to eq(user)
    end

    it "returns nil given bad credentials" do
      expect( User.find_by_credentials("john", "password")).to be_nil
    end

  end

end
