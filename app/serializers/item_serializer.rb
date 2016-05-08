class ItemSerializer < ActiveModel::Serializer
  attributes :id, :list_title, :description, :created_at

  def list_title
    object.list.title
  end

  def created_at
    object.created_at.strftime('%B %d, %Y')
  end
end
