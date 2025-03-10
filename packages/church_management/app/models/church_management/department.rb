# == Schema Information
#
# Table name: church_management_departments
#
#  id          :integer          not null, primary key
#  description :string           not null
#  name        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require_relative "../church_management"

class ChurchManagement::Department < ChurchManagement::ResourceRecord
  # add concerns above.

  # add model configurations above.

  # add belongs_to associations above.

  # add has_one associations above.

  has_many :department_memberships
  has_many :members, through: :department_memberships
  # add has_many associations above.

  # add attachments above.

  scope :associated_with_user, ->(user) {}
  # add scopes above.

  validates :name, presence: true
  validates :description, presence: true
  # add validations above.

  # add callbacks above.

  # add delegations above.

  # add misc attribute macros above.

  # add methods above.
end
