# frozen_string_literal: true

class Season < ApplicationRecord
  has_many :episodes
  validates_presence_of :title, :plot, :number
  # TODO: Create migration to uniqueness
end
