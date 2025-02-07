module ChurchMgmtDashboardPortal
  module ChurchManagement
    class MinistryPolicy < ::ChurchManagement::MinistryPolicy
      def create?
        true
      end
    end
  end
end
