# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SeasonsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/seasons').to route_to('seasons#index')
    end

    it 'routes to #show' do
      expect(get: '/seasons/1').to route_to('seasons#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/seasons').to route_to('seasons#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/seasons/1').to route_to('seasons#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/seasons/1').to route_to('seasons#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/seasons/1').to route_to('seasons#destroy', id: '1')
    end
  end
end
