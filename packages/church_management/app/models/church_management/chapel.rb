# == Schema Information
#
# Table name: church_management_chapels
#
#  id         :integer          not null, primary key
#  color      :string           not null
#  name       :string           not null
#  quarter    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require_relative "../church_management"

class ChurchManagement::Chapel < ChurchManagement::ResourceRecord
  dynamic_path_parameter :name

  validates :name, presence: true
  validates :color, presence: true
  validates :quarter, presence: true

  has_many :admin_users, class_name: "Profile"
  has_many :members

  enum :name, love: "Love", faith: "Faith", joy: "Joy", peace: "Peace"
  enum :color, red: "Red", green: "Green", yellow: "Yellow", blue: "Blue"

  scope :associated_with_church_management_chapel,
    ->(church_management_chapel) {}

  def to_label
    name.titlecase
  end
end
