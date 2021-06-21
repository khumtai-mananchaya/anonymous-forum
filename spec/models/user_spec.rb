require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has a valid factory' do
    expect(FactoryBot.build(:user)).to be_valid
  end

  it "is invalid without an username" do
    user = FactoryBot.build(:user, username: nil)
    expect(user).not_to be_valid
  end

  it "is invalid without an email" do
    user = FactoryBot.build(:user, email: nil)
    expect(user).not_to be_valid
  end

  it "is invalid without a password" do
    user = FactoryBot.build(:user, password: nil)
    expect(user).not_to be_valid
  end

  it "is invalid with a duplicate email address" do
    FactoryBot.create(:user, email: "testing@gmail.com")
    user = FactoryBot.build(:user, email: "testing@gmail.com")
    expect(user).not_to be_valid
  end

  it "is invalid with a duplicate username" do
    FactoryBot.create(:user, username: "duplicate")
    user = FactoryBot.build(:user, username: "duplicate")
    expect(user).not_to be_valid
   end
end
