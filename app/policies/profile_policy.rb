class ProfilePolicy < ::ResourcePolicy
  # Core actions

  def create?
    true
  end

  def read?
    true
  end

  # Core attributes

  def permitted_attributes_for_create
    [:name, :user, :phone_number]
  end

  def permitted_attributes_for_read
    [:name, :user, :phone_number]
  end

  # Associations

  def permitted_associations
    %i[]
  end
end
