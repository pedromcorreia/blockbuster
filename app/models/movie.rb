# frozen_string_literal: true

class Movie < ApplicationRecord
  validates_presence_of :title, :plot
end
