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
    [ :name, :phone_number, :role ]
  end

  def permitted_attributes_for_read
    [ :name, :phone_number, :role ]
  end

  # Associations

  def permitted_associations
    %i[]
  end
end
