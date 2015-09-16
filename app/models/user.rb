##
# Class: User model
#
class User < ActiveRecord::Base
  has_secure_password
  has_many :events

  ROLES = %w[admin user guest].freeze

  validates :email, presence: true
  validates :password, presence: true
  validates :role, inclusion: { in: ROLES, message: "%{value} is not a valid role" }

  before_create :set_auth_token

  def is?(current_role)
    role == current_role.to_s
  end

private

  def set_auth_token
    return if auth_token.present?
    self.auth_token = SecureRandom.uuid.gsub(/\-/,'')
  end
end
