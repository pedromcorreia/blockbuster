# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/seasons', type: :request do
  let(:invalid_attributes) do
    {
      plot: 1,
      title: '',
      number: ''
    }
  end

  describe 'GET /index' do
    let(:season) { create(:season) }
    before do
      create(:episode, season: season)
      get seasons_url, as: :json
    end

    it 'renders a successful response' do
      expect(response).to be_successful
    end

    it 'renders a successful created_at response' do
      expect(JSON.parse(response.body).map { |a| a['id'] })
        .to eq(Season.all.order(:created_at).pluck(:id))
    end

    it 'renders a with episodes' do
      expect(JSON.parse(response.body).first['episodes'].count)
        .to eq(season.episodes.count)
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      season = create(:season)
      get season_url(season), as: :json
      expect(response).to be_successful
    end
  end
end
