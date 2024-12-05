require 'rails_helper'

RSpec.describe User, type: :model do


  describe "validations" do
    # Validate user with matching password and password_confirmation fields
    it 'is not valid if password and password_confirmation do not match' do
      @user = User.new(
        first_name: 'Test',
        last_name: 'User',
        email:'test@test.com',
        password: 'password123',
        password_confirmation: 'password456'
      )
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    # Presence validation for password field
    it 'is not valid without a password' do
      @user = User.new(
        first_name: 'Test',
        last_name: 'User',
        email:'test@test.com',
        password: nil,
        password_confirmation: nil
      )
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    # Unique email and case insensitivity validation
    it 'is not valid with a case insensitive duplicate email' do
      User.create!(
        first_name: 'Test',
        last_name: 'User',
        email: 'test@test.com',
        password: 'password123',
        password_confirmation: 'password123'
      )
      @user = User.new(
        first_name: 'Test',
        last_name: 'User',
        email: 'TEST@TEST.COM',
        password: 'password456',
        password_confirmation: 'password456'
      )
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include("Email has already been taken")
    end

    # Presence validation for email field
    it 'is not valid without a email' do
      @user = User.new(
        first_name: 'Test',
        last_name: 'User',
        email: nil,
        password: 'password123',
        password_confirmation: 'password123'
      )
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    # Presence validation for first_name field
    it 'is not valid without a first name' do
      @user = User.new(
        first_name: nil,
        last_name: 'User',
        email: 'test@test.com',
        password: 'password123',
        password_confirmation: 'password123'
      )
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    # Presence validation for last_name field
    it 'is not valid without a last name' do
      @user = User.new(
        first_name: 'Test',
        last_name: nil,
        email: 'test@test.com',
        password: 'password123',
        password_confirmation: 'password123'
      )
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    # Password minumum length validation
    it 'is not valid when password is shorter than 6 characters' do
      @user = User.new(
        first_name: 'Test',
        last_name: 'User',
        email: 'test@test.com',
        password: '12345',
        password_confirmation: '12345'
      )
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end
  end


  describe '.authenticate_with_credentials' do
    before do
      # Set up valid user before each test case
      @user = User.create!(
        first_name: 'Test',
        last_name: 'User',
        email: 'test@test.com',
        password: 'password123',
        password_confirmation: 'password123'
      )
    end

    # Valid credentials should return the user
    it 'returns the user when given valid credentials' do
      authenticated_user = User.authenticate_with_credentials('test@test.com', 'password123')
      expect(authenticated_user).to eq(@user)
    end    
    
    # Invalid password should return nil
    it 'returns nil with invalid credentials' do
      authenticated_user = User.authenticate_with_credentials('test@test.com', 'wrongpassword')
      expect(authenticated_user).to be_nil
    end

    # Extra spaces around the email should not affect authentication
    it 'authenticates even with extra spaces around the email' do
      authenticated_user = User.authenticate_with_credentials(' test@test.com ', 'password123')
      expect(authenticated_user).to eq(@user)
    end

    # Authentication should be case-insensitive
    it 'authenticates with the correct email case insensitively' do
      authenticated_user = User.authenticate_with_credentials('TEST@TEST.COM', 'password123')
      expect(authenticated_user).to eq(@user)
    end
  end


end