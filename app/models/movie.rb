# frozen_string_literal: true

class Movie < ApplicationRecord
  has_many :purchases, as: :purchaseble
  validates_presence_of :title, :plot
  validates :title, uniqueness: true
end
