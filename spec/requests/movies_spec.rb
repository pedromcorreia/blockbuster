require 'rails_helper'

RSpec.describe '/movies', type: :request do
  let(:valid_attributes) do
    {
      plot: 'Plot',
      title: 'title'
    }
  end

  let(:invalid_attributes) do
    {
      plot: 1,
      title: ''
    }
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      build_list(:movie, 5)
      get movies_url, as: :json
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      movie = Movie.create! valid_attributes
      get movie_url(movie), as: :json
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Movie' do
        expect do
          post movies_url, params: { movie: valid_attributes }, as: :json
        end.to change(Movie, :count).by(1)
      end

      it 'renders a JSON response with the new movie' do
        post movies_url, params: { movie: valid_attributes }, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Movie' do
        expect do
          post movies_url, params: { movie: invalid_attributes }, as: :json
        end.to change(Movie, :count).by(0)
      end

      it 'renders a JSON response with errors for the new movie' do
        post movies_url, params: { movie: invalid_attributes }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end
end
