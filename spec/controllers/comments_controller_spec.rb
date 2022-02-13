# frozen_string_literal: true

describe ArticlesController do
  let(:valid_session) { {} }

  describe 'GET #index' do
    let(:article) { create :article }

    it 'returns a success response' do
      get :index, params: { article_id: article.id }, session: valid_session
      expect(response).to have_http_status(:ok)
    end
  end
end
