# frozen_string_literal: true

describe ArticlesController do
  describe '#index' do
    let_it_be(:articles) { create_list(:article, 3) }
    let_it_be(:old_article) { create(:article, created_at: 1.hour.ago) }
    let_it_be(:newer_article) { create(:article) }
    let(:expected_article) { Article.recent.second.id.to_s }
    subject { get :index }

    it 'should return success response' do
      subject

      expect(response).to have_http_status(:ok)
    end

    it 'should return proper json' do
      subject

      Article.recent.each_with_index do |article, index|
        expect(json_data[index]['attributes']).to eq({
                                                       'title' => article.title,
                                                       'content' => article.content,
                                                       'slug' => article.slug
                                                     })
      end
    end

    it 'should return articles in the proper order' do
      subject

      expect(json_data.first['id']).to eq(newer_article.id.to_s)
      expect(json_data.last['id']).to eq(old_article.id.to_s)
    end

    it 'should paginate results' do
      get :index, params: { page: 2, per_page: 1 }

      expect(json_data.length).to eq(1)
      expect(json_data.first['id']).to eq(expected_article)
    end
  end

  describe '#create' do
    subject { post :create }

    context 'when no code provided' do
      it_behaves_like 'forbidden_requests'
    end

    context 'when invalid code provided' do
      before { request.headers['authorization'] = 'Invalid token' }
      it_behaves_like 'forbidden_requests'
    end

    context 'when authorized' do
      let(:access_token) { create :access_token }
      before { request.headers['authorization'] = "Bearer #{access_token.token}" }

      context 'when invalid parameters provided' do
        let(:invalid_attributes) do
          {
            data: {
              attributes: {
                title: '',
                content: ''
              }
            }
          }
        end

        subject { post :create, params: invalid_attributes }

        it 'should return 422 status code' do
          subject
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'should return proper error json' do
          subject
          expect(json['errors']).to include(
            {
              'source' => { 'pointer' => '/data/attributes/title' },
              'detail' => "can't be blank"
            },
            {
              'source' => { 'pointer' => '/data/attributes/content' },
              'detail' => "can't be blank"
            },
            {
              'source' => { 'pointer' => '/data/attributes/slug' },
              'detail' => "can't be blank"
            }
          )
        end
      end
    end
  end
end
