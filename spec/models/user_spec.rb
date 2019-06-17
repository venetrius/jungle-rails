require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations: User' do
    # validation examples here
    subject {
      described_class.new(first_name: "Sonic", last_name: "Screwdriver",
      email: "a@a.com", password: "password", password_confirmation: "password")
    }


    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without a first_name" do
      subject.first_name = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a last_name" do
      subject.last_name = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a password" do
      subject.password = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a password_confirmation" do
      subject.password_confirmation = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a maching password and   password_confirmation field" do
      subject.password_confirmation = "pass"
      expect(subject).to_not be_valid
    end

    it "is not valid if password is shorter than 5 characters " do
      subject.password_confirmation = "pass"
      subject.password = "pass"
      expect(subject).to_not be_valid
    end
  end

  describe 'user authentication' do
    user = User.create(first_name: "Sonic", last_name: "Screwdriver",
      email: "test@test.com", password: "password", password_confirmation: "password")

    it "should return a User object if called with valid credentials" do
      expect(User.authenticate_with_credentials(user.email, user.password)).to be_instance_of(User)
    end

    it "should return a User object with eamil #{user.email} when called with valid credentials" do
      expect(User.authenticate_with_credentials(user.email, user.password).email).to eq(user.email)
    end

    it "should return nil if called with invalid email" do
      expect(User.authenticate_with_credentials(user.email+"invalid", user.password)).to be(nil)
    end

    it "should return nil if called with invalid password" do
      expect(User.authenticate_with_credentials(user.email, user.password+"invalid")).to be(nil)
    end

    it "should return a User object even if the email contains traling and taling spaces" do
      expect(User.authenticate_with_credentials("  #{user.email}  ", user.password)).to be_instance_of(User)
    end

    it "should return a User object even if the email is in uppercase" do
      expect(User.authenticate_with_credentials(user.email.upcase, user.password)).to be_instance_of(User)
    end
  end
end
