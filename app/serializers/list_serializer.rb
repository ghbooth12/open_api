class ListSerializer < ActiveModel::Serializer
  attributes :id, :creator, :title, :items, :status, :created_at

  def creator
    object.user.username
  end

  def items
    object.items.map do |item|
      { id: item.id, description: item.description, completed: item.completed }
    end
  end

  def status
    if object.private
      "Private List"
    elsif object.private == false
      "Public List"
    end
  end

  def created_at
    object.created_at.strftime('%B %d, %Y')
  end
end
