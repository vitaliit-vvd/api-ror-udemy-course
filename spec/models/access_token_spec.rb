# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AccessToken, type: :model do
  describe 'with validations' do
    let(:access_token) { create(:access_token) }

    it 'should have valid factory' do
      expect(access_token).to be_valid
    end

    it 'should validate token' do
      expect(build(:access_token, token: '')).to be_invalid
      expect(build(:access_token, token: access_token.token)).to be_invalid
    end
  end

  describe '#new' do
    let(:user) { create(:user) }

    it 'should have a token present after initialize' do
      expect(AccessToken.new.token).to be_present
    end

    it 'should generate uniq token' do
      expect { user.create_access_token }.to change { AccessToken.count }.by(1)
      expect(user.build_access_token).to be_valid
    end
  end
end
