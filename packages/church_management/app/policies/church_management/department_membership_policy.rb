class ChurchManagement::DepartmentMembershipPolicy < ChurchManagement::ResourcePolicy
  # Core actions

  def new?
    false
  end

  def edit?
    true
  end

  def read?
    true
  end

  # Core attributes

  def permitted_attributes_for_create
    [:member, :department, :role]
  end

  def permitted_attributes_for_read
    [:member, :department, :role]
  end

  # Associations

  def permitted_associations
    %i[]
  end
end
