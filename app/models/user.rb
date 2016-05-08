class User < ActiveRecord::Base
  has_many :lists, dependent: :destroy

  before_save { self.username = username.split(' ').map{|name| name.capitalize}.join(' ') }
  before_save { self.email = email.downcase }

  validates :username, length: { in: 1..100 }, presence: true
  validates :email, length: { in: 3..254 }, uniqueness: { case_sensitive: false }, presence: true
  validates :password, length: { in: 6..100 }, presence: true
end
