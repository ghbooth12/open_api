class UserSerializer < ActiveModel::Serializer
  attributes :id, :full_name, :email, :created_at

  def full_name
    object.username
  end

  def created_at
    object.created_at.strftime('%B %d, %Y')
  end
end
