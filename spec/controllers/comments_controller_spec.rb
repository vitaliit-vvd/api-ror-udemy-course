# frozen_string_literal: true

describe CommentsController do
  let(:article) { create :article }

  describe 'GET #index' do
    it 'returns a success response' do
      get :index, params: { article_id: article.id }
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST #create' do
    let(:valid_attributes) { { content: 'My awesome comment for article' } }
    let(:invalid_attributes) { { content: '' } }

    context 'when not authorized' do
      subject { post :create, params: { article_id: article.id } }

      it_behaves_like 'forbidden_requests'
    end

    context 'when authorized' do
      let(:user) { create :user }
      let(:access_token) { user.create_access_token }

      before { request.headers['authorization'] = "Bearer #{access_token.token}" }

      context 'with valid params' do
        it 'creates a new comment' do
          expect do
            post :create, params: { article_id: article.id, comment: valid_attributes }
          end.to change(Comment, :count).by(1)
        end

        it 'renders a JSON response with the new comment' do
          post :create, params: { article_id: article.id, comment: valid_attributes }
          expect(response).to have_http_status(:created)
          expect(response.content_type).to eq('application/json; charset=utf-8')
          expect(response.location).to eq(article_url(article))
        end
      end
    end
  end
end
