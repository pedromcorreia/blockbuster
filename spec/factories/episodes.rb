# frozen_string_literal: true

FactoryBot.define do
  factory :episode do
    title { 'title' }
    plot { 'plot' }
    season { nil }
  end
end
