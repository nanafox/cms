class ChapelMgmtDashboardPortal::ChurchManagement::ChapelPolicy < ::ChurchManagement::ChapelPolicy
  relation_scope do |relation|
    relation.where(id: user.chapel.id)
  end

  def permitted_associations
    %i[members]
  end
end
