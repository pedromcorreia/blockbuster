# frozen_string_literal: true

class User < ApplicationRecord
  has_many :purchase, dependent: :destroy
  validates :email, presence: true,
                    format: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i,
                    uniqueness: true
end
