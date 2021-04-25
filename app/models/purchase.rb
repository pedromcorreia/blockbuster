class Purchase < ApplicationRecord
  belongs_to :purchaseble, polymorphic: true
  belongs_to :user
  validates_inclusion_of :quality, in: %w[hd sd]

  before_save :default_price

  DEFAULT_PRICE = 299

  def default_price
    self.price = DEFAULT_PRICE
  end
end
