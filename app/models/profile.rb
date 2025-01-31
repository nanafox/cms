# == Schema Information
#
# Table name: profiles
#
#  id           :integer          not null, primary key
#  name         :string           not null
#  phone_number :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :integer          not null
#
# Indexes
#
#  index_profiles_on_user_id  (user_id) UNIQUE
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
class Profile < ::ResourceRecord
  belongs_to :user

  validates :name, presence: true
  validates :phone_number, presence: true

  attribute :role
  validates :role, presence: true, on: :create

  def role
    user.role.to_label
  end

  after_create :set_user_role

  private

    def set_user_role
      unless user.role.present?
        Role.create!(name: role, roleable: user)
      end
    end
end
