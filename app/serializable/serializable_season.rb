class SerializableSeason < JSONAPI::Serializable::Resource
  type 'season'

  attributes :title, :plot, :number

  has_many :episodes
end
