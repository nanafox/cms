# == Schema Information
#
# Table name: users
#
#  id            :integer          not null, primary key
#  email         :string           not null
#  password_hash :string
#  status        :integer          default("unverified"), not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE WHERE status IN (1, 2)
#
class User < ResourceRecord
  include Rodauth::Rails.model(:user)

  has_one :role, as: :roleable
  has_one :profile, dependent: :destroy

  validates :email, presence: true

  enum :status, unverified: 1, verified: 2, closed: 3

  scope :associated_with_user, ->(user) { }

  def to_label
    "#{profile.name} - #{role.to_label}"
  end
end
