# == Schema Information
#
# Table name: profiles
#
#  id           :integer          not null, primary key
#  name         :string           not null
#  phone_number :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  chapel_id    :integer          not null
#  user_id      :integer          not null
#
# Indexes
#
#  index_profiles_on_chapel_id  (chapel_id)
#  index_profiles_on_user_id    (user_id) UNIQUE
#
# Foreign Keys
#
#  chapel_id  (chapel_id => church_management_chapels.id)
#  user_id    (user_id => users.id)
#
class Profile < ::ResourceRecord
  attr_reader :administrative_role

  belongs_to :user
  belongs_to :chapel, class_name: "ChurchManagement::Chapel"
  validates :name, presence: true
  validates :phone_number, presence: true

  attribute :role
  validates :role, presence: true, on: :create

  before_create :set_user_role

  def administrative_role
    user.role.to_label
  end

  private

    def set_user_role
      unless user.role.present?
        Role.create!(name: role, roleable: user)
      end
    end
end
