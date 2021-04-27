require 'rails_helper'

RSpec.describe '/purchases', type: :request do
  let(:user) { create(:user) }
  let(:movie) { create(:movie) }
  let(:purchase) { create(:purchase, user: user) }
  let(:valid_attributes) { build(:purchase) }
  let(:invalid_attributes) { build(:purchase, quality: 'invalid') }

  describe 'GET /index' do
    it 'renders a successful response' do
      get "/users/#{user.id}/purchases", as: :json
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    context 'with same user' do
      it 'renders a successful response' do
        get "/users/#{user.id}/purchases/#{purchase.id}", as: :json
        expect(response).to be_successful
        expect(Purchase.new(JSON.parse(response.body))).to eq(Purchase.find(purchase.id))
      end
    end

    context 'with not same user' do
      it 'renders a JSON response with not_found' do
        user1 = create(:user)
        get "/users/#{user1.id}/purchases/#{purchase.id}", as: :json
        expect(response).not_to be_successful
        expect(JSON.parse(response.body)['error']).to include("Couldn't find Purchase")
      end
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
        expect(response.content_type).to match(a_string_including('application/json'))
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
