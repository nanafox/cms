# == Schema Information
#
# Table name: church_management_department_memberships
#
#  id            :integer          not null, primary key
#  role          :integer          not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  department_id :integer          not null
#  member_id     :integer          not null
#
# Indexes
#
#  idx_on_department_id_8fc1e61721                              (department_id)
#  idx_on_member_id_department_id_3d84d256d8                    (member_id,department_id) UNIQUE
#  index_church_management_department_memberships_on_member_id  (member_id)
#
# Foreign Keys
#
#  department_id  (department_id => church_management_departments.id)
#  member_id      (member_id => church_management_members.id)
#
require_relative "../church_management"

class ChurchManagement::DepartmentMembership < ChurchManagement::ResourceRecord
  include MembershipRole
  # add concerns above.

  # add model configurations above.

  belongs_to :member, class_name: "ChurchManagement::Member"
  belongs_to :department, class_name: "ChurchManagement::Department"
  # add belongs_to associations above.

  # add has_one associations above.

  # add has_many associations above.

  # add attachments above.

  scope :associated_with_user, ->(user) {}
  # add scopes above.

  validates :role, presence: true
  validates :member,
    uniqueness: {
      scope: :department_id, message: "is already in this department"
    }
  # add validations above.

  # add callbacks above.

  # add delegations above.

  # add misc attribute macros above.

  # add methods above.
end
