module ChurchMgmtDashboardPortal
  module ChurchManagement
    class MemberPolicy < ::ChurchManagement::MemberPolicy
      relation_scope do |relation|
        relation
      end

      def permitted_attributes_for_index
        super + [:chapel]
      end

      def permitted_attributes_for_show
        super + [:chapel]
      end
    end
  end
end
