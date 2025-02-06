module ChurchMgmtDashboardPortal
  module ChurchManagement
    class MemberPolicy < ::ChurchManagement::MemberPolicy
      def add_to_ministry?
        true
      end

      relation_scope do |relation|
        relation
      end

      def permitted_attributes_for_index
        super + [:chapel]
      end

      def permitted_associations
        %i[chapel] + super
      end
    end
  end
end
