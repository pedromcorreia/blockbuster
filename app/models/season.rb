class Season < ApplicationRecord
  has_many :episode
  validates_presence_of :title, :plot
end
