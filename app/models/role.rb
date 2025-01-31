# == Schema Information
#
# Table name: roles
#
#  id            :integer          not null, primary key
#  name          :string           not null
#  roleable_type :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  roleable_id   :integer
#
# Indexes
#
#  index_roles_on_roleable  (roleable_type,roleable_id) UNIQUE
#
class Role < ::ResourceRecord
  belongs_to :roleable, polymorphic: true

  enum :name,
    # User roles
    church_admin: "Church Admin", chapel_leader: "Chapel Leader",
    member: "Member", instrumentalist: "Instrumentalist",
    accountant: "Accountant", usher: "Usher", security: "Security",
    prayer_warrior: "Prayer Warrior", evangelist: "Evangelist", pastor: "Pastor"

  validates :name, presence: true

  scope :admin_roles, -> { %w[church_admin chapel_leader accountant] }

  def to_label
    name.titleize
  end
end
