class List < ActiveRecord::Base
  belongs_to :user
  has_many :items, dependent: :destroy

  validates :title, length: { in: 1..100 }, presence: true
  validate :public_list?, on: :update
  validates :private, inclusion: { in: [true, false], message: "value should be 'true' or 'false'." }, allow_blank: false

  scope :visible, -> (current_user, user) { current_user == user ? all : where(private: false) }

  private

  # Public list can't be editted. Change it to private first then edit/update.
  def public_list?
    unless self.private || self.private_changed?
      errors.add(:list, "can't be updated for the public list.")
    end
  end
end
