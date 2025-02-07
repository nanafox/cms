module ChurchMgmtDashboardPortal
  module ChurchManagement
    class MemberDefinition < ::ChurchManagement::MemberDefinition
      edit_page_title "Update member details"
      edit_page_description "As the Church Administrator, you have access to " \
                            "update details of members from other chapels. " \
                            "Be careful when making updates!"

      new_page_title "Add new member"
      new_page_description "Register a new member. " \
                           "NOTE: The Chapel is automatically set based " \
                           "on their date of birth."
      ::ChurchManagement::Chapel.names.keys.each do |chapel|
        scope(chapel) do |member|
          member.joins(:chapel).where(chapel: [name: chapel])
        end
      end
    end
  end
end
