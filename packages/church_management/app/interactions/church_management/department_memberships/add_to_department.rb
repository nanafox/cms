module ChurchManagement
  module DepartmentMemberships
    class AddToDepartment < ::ResourceInteraction
      presents label: "Add to Department", icon: Phlex::TablerIcons::UsersGroup
      attribute :resource

      attribute :department
      attribute :role

      field :department,
        choices: -> {
          ::ChurchManagement::Department
            .pluck(:id, :name).to_h.each_pair { |id, department|
            [id, department]
          }
        }, required: true, hint: "Select the department to add this member."

      field :role,
        choices: ChurchManagement::DepartmentMembership.roles.to_h { |role|
          [role.to_sym, role.titleize]
        }, hint: "The role of the member in this department.", required: true

      validates :department, presence: true
      validates :role, presence: true

      def execute
        db_department = ChurchManagement::Department.find(department)

        membership = resource.department_memberships.build(
          role: role.to_sym, department: db_department
        )

        if membership.save
          succeed(resource)
            .with_message(
              "#{resource.full_name} has been added to the " \
              "#{db_department.name} Department"
            )
        else
          failed(membership.errors)
        end
      end
    end
  end
end
