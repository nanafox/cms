module ChurchManagement
  module MinistryMemberships
    class AddToMinistry < ::ResourceInteraction
      presents label: "Add to Ministry", icon: Phlex::TablerIcons::UsersGroup
      attribute :resource

      attribute :ministry
      attribute :role

      field :ministry,
            choices: -> {
              ChurchManagement::Ministry
                .pluck(:id, :name).to_h.each_pair { |id, ministry|
                [id, ministry]
              }
            }, required: true, hint: "Select the ministry to add this member."

      field :role,
            choices: ChurchManagement::MinistryMembership.roles.to_h { |role|
              [role.to_sym, role.titleize]
            }, hint: "The role of the member in this ministry.", required: true

      validates :ministry, presence: true
      validates :role, presence: true

      def execute
        db_ministry = ChurchManagement::Ministry.find(ministry)

        membership = resource.ministry_memberships.build(
          role: role.to_sym, ministry: db_ministry,
        )

        if membership.save
          succeed(resource)
            .with_message(
              "#{resource.full_name} has been added to the " \
              "#{db_ministry.name} Ministry"
            )
        else
          failed(membership.errors)
        end
      end
    end
  end
end
