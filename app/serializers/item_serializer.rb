class ItemSerializer < ActiveModel::Serializer
  attributes :id, :belong_to, :name, :created_at

  def belong_to
    object.list.title
  end

  def created_at
    object.created_at.strftime('%B %d, %Y')
  end
end
