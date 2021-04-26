# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/movies', type: :request do
  let(:invalid_attributes) do
    {
      plot: 1,
      title: ''
    }
  end

  describe 'GET /index' do
    it 'renders a successful response ordered by created_at' do
      create_list(:movie, 5)
      get movies_url, as: :json
      expect(response).to be_successful
      expect(Movie.all.order(:created_at).pluck(:id))
        .to eq(JSON.parse(response.body).map { |a| a['id'] })
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      movie = create(:movie)
      get movie_url(movie), as: :json
      expect(response).to be_successful
    end
  end
end
