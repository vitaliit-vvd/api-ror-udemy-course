# frozen_string_literal: true

describe ArticlesController do
  describe '#index' do
    let_it_be(:articles) { create_list(:article, 3) }
    let_it_be(:old_article) { create(:article, created_at: 1.hour.ago) }
    let_it_be(:newer_article) { create(:article) }
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
  end
end
