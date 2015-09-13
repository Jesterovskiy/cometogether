##
# Class: User model
#
class User < ActiveRecord::Base
  has_many :events

  validates :email, presence: true
  validates :password, presence: true
end
