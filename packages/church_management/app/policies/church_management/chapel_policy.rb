class ChurchManagement::ChapelPolicy < ChurchManagement::ResourcePolicy
  # Core actions

  def create?
    false
  end

  def read?
    true
  end

  # Core attributes

  def permitted_attributes_for_read
    [ :name, :color ]
  end

  # Associations

  def permitted_associations
    %i[admin_users]
  end
end
