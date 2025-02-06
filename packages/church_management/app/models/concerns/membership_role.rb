module MembershipRole
  extend ActiveSupport::Concern

  included do
    enum :role, leader: 0, member: 1
  end
end
