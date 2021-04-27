class SerializablePurchase < JSONAPI::Serializable::Resource
  DEFAULT_TIME_TO_REPURCHASE = 2.days.ago
  type 'movies'

  attributes :price, :quality, :purchaseble_type, :purchaseble_id

  attribute :remaining_time do
    ((@object.created_at - DEFAULT_TIME_TO_REPURCHASE) / 1.hour).round
  end
end
