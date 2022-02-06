# frozen_string_literal: true

describe ArticlesController do
  describe '#index' do
    it 'should return success response' do
      get :index
      expect(response).to have_http_status(:ok)
    end
  end

  it 'should return proper json' do
    get :index
    json = JSON.parse(response.body)
    pp json
    # json_data = json[:data]
    # expect(json_data.length).to eq(2)
  end
end
