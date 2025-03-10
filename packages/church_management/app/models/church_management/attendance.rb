# == Schema Information
#
# Table name: church_management_attendances
#
#  id          :integer          not null, primary key
#  date        :date             not null
#  status      :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  member_id   :integer          not null
#  recorder_id :integer          not null
#
# Indexes
#
#  index_church_management_attendances_on_date_and_member_id  (date,member_id) UNIQUE
#  index_church_management_attendances_on_member_id           (member_id)
#  index_church_management_attendances_on_recorder_id         (recorder_id)
#
# Foreign Keys
#
#  member_id    (member_id => church_management_members.id)
#  recorder_id  (recorder_id => users.id)
#
require_relative "../church_management"

class ChurchManagement::Attendance < ChurchManagement::ResourceRecord
  # add concerns above.

  enum :status, absent: 0, present: 1
  # add model configurations above.

  belongs_to :member, class_name: "ChurchManagement::Member"
  belongs_to :recorder, class_name: "User", foreign_key: "recorder_id"
  # add belongs_to associations above.

  # add has_one associations above.

  # add has_many associations above.

  # add attachments above.

  # add scopes above.

  validates :date, presence: true
  validates :status, presence: true

  validates :member,
    uniqueness: {scope: :date, message: "has been marked already for today"}
  # add validations above.

  # add callbacks above.

  # add delegations above.

  # add misc attribute macros above.

  # add methods above.
end
