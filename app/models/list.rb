class List < ActiveRecord::Base
  belongs_to :user
  has_many :items, dependent: :destroy

  validates :title, length: { in: 1..100 }, presence: true
  validates :private, inclusion: { in: [true, false], message: "The private value should be 'true' or 'false'." }, allow_blank: false
end
