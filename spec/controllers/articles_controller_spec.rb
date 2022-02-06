# frozen_string_literal: true

describe ArticlesController do
  describe '#index' do
    let!(:articles) { create_list(:article, 3) }
    subject { get :index }

    it 'should return success response' do
      subject

      expect(response).to have_http_status(:ok)
    end

    it 'should return proper json' do
      subject

      articles.each_with_index do |article, index|
        expect(json_data[index]['attributes']).to eq({
                                                       'title' => article.title,
                                                       'content' => article.content,
                                                       'slug' => article.slug
                                                     })
      end
    end
  end
end
