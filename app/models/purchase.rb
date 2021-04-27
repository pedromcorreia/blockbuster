# frozen_string_literal: true

class Purchase < ApplicationRecord
  DEFAULT_PRICE = 299
  DEFAULT_TIME_TO_REPURCHASE = 2.days.ago

  belongs_to :purchaseble, polymorphic: true
  belongs_to :user
  validates_presence_of :price
  validates_inclusion_of :quality, in: %w[hd sd]
  validate :can_purchase?

  before_save :default_price

  scope :available, -> { where('created_at > ?', DEFAULT_TIME_TO_REPURCHASE).order(:created_at) }

  def default_price
    self.price = DEFAULT_PRICE
  end

  def can_purchase?
    purchase = user.purchases.find_by(purchaseble_id: purchaseble_id)
    return unless purchase && DEFAULT_TIME_TO_REPURCHASE < purchase.created_at

    errors.add(:purchaseble_id, 'user need to wait to repurchase the media')
  end
end
