# == Schema Information
#
# Table name: users
#
#  id            :integer          not null, primary key
#  email         :string           not null
#  password_hash :string
#  role          :integer
#  status        :integer          default("unverified"), not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE WHERE status IN (1, 2)
#
class User < ResourceRecord
  include Rodauth::Rails.model(:user)

  has_one :profile, dependent: :destroy
  has_one :chapel, through: :profile

  validates :email, presence: true

  enum :role, church_admin: 0, chapel_leader: 1, accountant: 2
  enum :status, unverified: 1, verified: 2, closed: 3

  scope :associated_with_user, ->(user) {}

  def to_label
    "#{profile.name} - #{role.titleize}"
  end
end
