class ChurchManagement::MinistryMembershipPolicy < ChurchManagement::ResourcePolicy
  # Core actions

  def create?
    false
  end

  def read?
    true
  end

  # Core attributes

  def permitted_attributes_for_create
    [:member, :role, :ministry]
  end

  def permitted_attributes_for_read
    [:member, :role, :ministry]
  end

  # Associations

  def permitted_associations
    %i[]
  end
end
