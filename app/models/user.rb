##
# Class: User model
#
class User < ActiveRecord::Base
  has_many :events
end
