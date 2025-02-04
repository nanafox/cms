module ChurchMgmtDashboardPortal
  module ChurchManagement
    class MemberDefinition < ::ChurchManagement::MemberDefinition
      ChurchManagement::Chapel.names.keys.each do |chapel|
        scope(chapel) do |member|
          member.joins(:chapel).where(chapel: [name: chapel])
        end
      end
    end
  end
end
