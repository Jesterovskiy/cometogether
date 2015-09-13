##
# Class: Event model
#
class Event < ActiveRecord::Base
  has_many :items
  belongs_to :user

  validates :name, presence: true
end
