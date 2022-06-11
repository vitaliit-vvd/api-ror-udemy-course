# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'with validations' do
    let_it_be(:user) { create(:user) }
    let_it_be(:other_user) { build(:user, login: user.login) }
    let_it_be(:invalid_user) { build(:user, login: nil, provider: nil) }

    it 'should have valid factory' do
      expect(user).to be_valid
    end

    it 'should validate presence of attributes' do
      expect(invalid_user).not_to be_valid
      expect(invalid_user.errors.messages[:login]).to include("can't be blank")
      expect(invalid_user.errors.messages[:provider]).to include("can't be blank")
    end

    it 'should validate presence of password for standard provider' do
      user = build :user, login: 'jsmith', provider: 'standard', password: nil
      expect(user).not_to be_valid
      expect(user.errors.messages[:password]).to include("can't be blank")
    end

    it 'should validate uniqueness of login' do
      expect(other_user).not_to be_valid

      other_user.login = 'newlogin'
      expect(other_user).to be_valid
    end
  end
end
