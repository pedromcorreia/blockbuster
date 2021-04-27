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
    it 'renders a successful response' do
      create(:season)
      get seasons_url, as: :json
      byebug
      expect(response).to be_successful
      expect(Season.all.order(:created_at).pluck(:id))
        .to eq(JSON.parse(response.body).map { |a| a['id'] })
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
