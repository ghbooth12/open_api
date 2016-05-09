class ListSerializer < ActiveModel::Serializer
  attributes :id, :creator, :title, :items, :private, :created_at

  def creator
    object.user.username
  end

  def items
    object.items.map do |item|
      { id: item.id, description: item.description, completed: item.completed }
    end
  end

  def created_at
    object.created_at.strftime('%B %d, %Y')
  end
end
