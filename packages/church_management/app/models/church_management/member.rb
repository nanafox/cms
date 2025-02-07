# == Schema Information
#
# Table name: church_management_members
#
#  id                      :integer          not null, primary key
#  date_of_birth           :date             not null
#  email_address           :string
#  employment_status       :integer          not null
#  first_name              :string           not null
#  last_name               :string           not null
#  marital_status          :integer          not null
#  middle_name             :string
#  primary_phone_number    :string           not null
#  residential_address     :string           not null
#  whatsapp_account_number :string
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  chapel_id               :integer          not null
#  creator_id              :integer          not null
#
# Indexes
#
#  index_church_management_members_on_chapel_id   (chapel_id)
#  index_church_management_members_on_creator_id  (creator_id)
#
# Foreign Keys
#
#  chapel_id   (chapel_id => church_management_chapels.id)
#  creator_id  (creator_id => users.id)
#
require_relative "../church_management"

class ChurchManagement::Member < ChurchManagement::ResourceRecord
  # add concerns above.

  enum :marital_status,
    single: 0,
    married: 1,
    divorced: 2,
    separated: 3,
    widowed: 4

  enum :employment_status, employed: 0, unemployed: 1, student: 2
  # add model configurations above.

  belongs_to :creator, class_name: "User", foreign_key: "creator_id"
  belongs_to :chapel, class_name: "ChurchManagement::Chapel"
  # add belongs_to associations above.

  # add has_one associations above.

  has_many :ministry_memberships, class_name: "ChurchManagement::MinistryMembership"
  has_many :ministries, through: :ministry_memberships
  # add has_many associations above.

  # add attachments above.

  class << self
    ChurchManagement::Chapel.names.keys.each do |chapel_name|
      define_method chapel_name do
        joins(:chapel).where(church_management_chapels: { name: chapel_name })
      end
    end
  end
  # add scopes above.

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :date_of_birth, presence: true
  validates :marital_status, presence: true
  validates :residential_address, presence: true
  validates :primary_phone_number, presence: true
  validates :employment_status, presence: true
  # add validations above.

  before_validation :set_chapel
  before_save :validate_chapel_admin, :set_chapel
  # add callbacks above.

  # add delegations above.

  # add misc attribute macros above.

  def to_label
    full_name
  end

  def full_name
    if middle_name.present?
      "#{first_name} #{middle_name} #{last_name}"
    else
      "#{first_name} #{last_name}"
    end
  end

  # add methods above.
  private

  def set_chapel
    if date_of_birth.present?
      self.chapel = ChurchManagement::Chapel.find_by(
        quarter: date_of_birth.quarter,
      )
    else
      errors.add(:date_of_birth, "must be present")
      throw(:abort)
    end
  end

  def validate_chapel_admin
    return if creator.church_admin?

    if creator.accountant?
      errors.add(base: "You are not allowed to perform this action")
      throw(:abort)
    end

    if creator.chapel_leader? && creator.chapel != chapel
      errors.add(
        :date_of_birth,
        "You are not allowed to create or update a member for another chapel." \
        " Contact a Church Administrator to facilitate the necessary change"
      )
      throw(:abort)
    end
  end
end
