class ChurchManagement::AttendancePolicy < ChurchManagement::ResourcePolicy
  # Core actions

  def create?
    true
  end

  def read?
    true
  end

  # Core attributes

  def permitted_attributes_for_create
    [:member, :date, :status]
  end

  def permitted_attributes_for_read
    [:member, :date, :status]
  end

  relation_scope do |relation|
    if user.church_admin?
      relation
    elsif user.chapel_leader?
      relation.joins(:member).where(member: { chapel: user.chapel })
    else
      relation.none
    end
  end

  # Associations

  def permitted_associations
    %i[]
  end
end
