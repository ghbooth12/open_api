class List < ActiveRecord::Base
  belongs_to :user
  has_many :items, dependent: :destroy

  # before_save { self.private ||= false }

  validates :title, length: { in: 1..100 }, presence: true
  # validates :private, inclusion: { in: [true, false], message: "#{private} is not a valid value for private." }, allow_blank: true
end
