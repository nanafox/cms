class RolePolicy < ::ResourcePolicy
  # Core actions

  def create?
    true
  end

  def read?
    true
  end

  # Core attributes

  def permitted_attributes_for_create
    [:name, :roleable]
  end

  def permitted_attributes_for_read
    [:name, :roleable]
  end

  # Associations

  def permitted_associations
    %i[]
  end
end
