class SerializableMovie < JSONAPI::Serializable::Resource
  type 'movies'

  attributes :title, :plot, :number

  has_many :episodes do
    data do
      @object.episodes
    end

    meta do
      { count: @object.published_comments.count }
    end
  end

  meta do
    { featured: true }
  end
end
