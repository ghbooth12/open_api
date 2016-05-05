class User < ActiveRecord::Base
  has_many :lists, dependent: :destroy
end
