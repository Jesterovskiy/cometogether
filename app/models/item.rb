##
# Class: Item model
#
class Item < ActiveRecord::Base
  belongs_to :event

  validates :description, presence: true
end
