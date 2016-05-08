class Item < ActiveRecord::Base
  belongs_to :list

  validates :description, length: { in: 1..100 }, presence: true
end
