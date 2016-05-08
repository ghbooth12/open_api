class ListSerializer < ActiveModel::Serializer
  attributes :id, :creator, :title, :private, :created_at

  def creator
    object.user.username
  end

  def created_at
    object.created_at.strftime('%B %d, %Y')
  end
end
