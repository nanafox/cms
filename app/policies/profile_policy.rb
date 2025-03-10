class ProfilePolicy < ::ResourcePolicy
  # Core actions

  def create?
    user.profile.blank?
  end

  def read?
    true
  end

  def destroy?
    false
  end

  # Core attributes

  def permitted_attributes_for_create
    [:name, :phone_number, :role, :chapel]
  end

  def permitted_attributes_for_update
    [:name, :phone_number]
  end

  def permitted_attributes_for_read
    [:name, :phone_number, :administrative_role, :chapel]
  end

  # Associations

  def permitted_associations
    %i[]
  end
end
