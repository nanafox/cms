class ChurchManagement::DepartmentMembershipDefinition < ChurchManagement::ResourceDefinition
  display :role, formatter: ->(value) { value.titleize }
end
