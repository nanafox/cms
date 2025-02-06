class ChurchManagement::MinistryMembershipDefinition < ChurchManagement::ResourceDefinition
  edit_page_title "Update ministry membership details"
  # edit_page_description ""

  field :role,
        choices: ChurchManagement::MinistryMembership
          .roles.to_h { |role| [role.to_sym, role.titleize] }
end
