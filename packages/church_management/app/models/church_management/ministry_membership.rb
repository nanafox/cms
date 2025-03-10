# == Schema Information
#
# Table name: church_management_ministry_memberships
#
#  id          :integer          not null, primary key
#  role        :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  member_id   :integer          not null
#  ministry_id :integer          not null
#
# Indexes
#
#  idx_on_ministry_id_member_id_dc050155b3                      (ministry_id,member_id) UNIQUE
#  index_church_management_ministry_memberships_on_member_id    (member_id)
#  index_church_management_ministry_memberships_on_ministry_id  (ministry_id)
#
# Foreign Keys
#
#  member_id    (member_id => church_management_members.id)
#  ministry_id  (ministry_id => church_management_ministries.id)
#
require_relative "../church_management"

class ChurchManagement::MinistryMembership < ChurchManagement::ResourceRecord
  include MembershipRole
  # add concerns above.

  # add model configurations above.

  belongs_to :member, class_name: "ChurchManagement::Member"
  belongs_to :ministry, class_name: "ChurchManagement::Ministry"
  # add belongs_to associations above.

  # add has_one associations above.

  # add has_many associations above.

  # add attachments above.

  scope :associated_with_user, ->(user) {}
  # add scopes above.

  validates :role, presence: true
  validates :member, presence: true,
    uniqueness: {scope: :ministry_id, message: "is already in this ministry"}
  validate :cant_join_single_breed_and_singles
  # add validations above.

  # add callbacks above.

  # add delegations above.

  # add misc attribute macros above.

  def to_label
    "#{member.full_name} > #{ministry.name} Ministry"
  end

  def cant_join_single_breed_and_singles
    return unless ministry.name == "New Breed" || ministry.name == "Singles"
    error = "can't join both Singles and New Breed ministries at the same time"

    if ministry.name == "New Breed" &&
        member.in?(ChurchManagement::Ministry.find_by(name: "Singles").members)
      errors.add(:member, error)
    elsif ministry.name == "Singles" &&
        member.in?(ChurchManagement::Ministry.find_by(name: "New Breed").members)
      errors.add(:member, error)
    end
  end

  # add methods above.
end
