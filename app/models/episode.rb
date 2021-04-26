# frozen_string_literal: true

class Episode < ApplicationRecord
  belongs_to :season
  validates_presence_of :title, :plot
  validates :title, uniqueness: true
end
