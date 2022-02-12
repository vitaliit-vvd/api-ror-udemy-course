# frozen_string_literal: true

describe UserAuthenticator do
  describe '#perform' do
    context 'when code is incorrect' do
      let(:authenticator) { described_class.new('sample_code') }

      it 'should raise an error' do
        expect { authenticator.perform }.to raise_error(
          UserAuthenticator::AuthenticationError
        )
        expect(authenticator.user).to be_nil
      end
    end
  end
end
