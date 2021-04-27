require 'rails_helper'

RSpec.describe '/purchases', type: :request do
  include ActiveSupport::Testing::TimeHelpers
  let(:user) { create(:user) }
  let(:movie) { create(:movie) }
  let(:purchase) { create(:purchase, user: user) }
  let(:valid_attributes) { build(:purchase) }
  let(:invalid_attributes) { build(:purchase, quality: 'invalid') }

  describe 'GET /index' do
    before do
      travel_to(1.days.ago)
      create_list(:purchase, 2, user: user)
      travel_back
      travel_to(3.days.ago)
      create_list(:purchase, 3, user: user)
      travel_back
      get "/users/#{user.id}/purchases", as: :json
    end
    it 'renders a successful response' do
      expect(response).to be_successful
    end
    it 'renders a successful response order remaining times' do
      response_list =
        JSON.parse(response.body)['data'].map { |i| i['attributes']['remaining_time'] }
      expect(response_list).to eq([24, 24])
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Purchase' do
        expect do
          post "/users/#{user.id}/purchases/", params: { purchase: valid_attributes }, as: :json
        end.to change(Purchase, :count).by(1)
      end

      it 'renders a JSON response with the new purchase' do
        post "/users/#{user.id}/purchases/", params: { purchase: valid_attributes }, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/vnd.api+json; charset=utf-8'))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Purchase' do
        expect do
          post "/users/#{user.id}/purchases/", params: { purchase: invalid_attributes }, as: :json
        end.to change(Purchase, :count).by(0)
      end

      it 'renders a JSON response with errors for the new purchase' do
        post "/users/#{user.id}/purchases/", params: { purchase: invalid_attributes }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context 'with invalid user' do
      it 'does not create a new Purchase' do
        expect do
          post '/users/-1/purchases/', params: { purchase: valid_attributes }, as: :json
        end.to change(Purchase, :count).by(0)
      end

      it 'renders a JSON response with not_found' do
        post '/users/-1/purchases/', params: { purchase: valid_attributes }, as: :json
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
