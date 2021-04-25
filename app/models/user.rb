class User < ApplicationRecord
  has_many :purchase, dependent: :destroy
  validates :email, presence: true, format: /\w+@\w+\.{1}[a-zA-Z]{2,}/
end
