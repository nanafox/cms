class ProfileDefinition < ::ResourceDefinition
  new_page_title "Complete your profile to continue"
  new_page_description "Ensure you provide the correct information. " \
                       "Your role will determine what you are allowed to " \
                       "access and responsible for."

  field :name,
        hint: "Enter your full name. This is how other users will know you."

  field :role, choices: Role.names.keys.select { |role|
                 %w[church_admin chapel_leader accountant].include?(role)
               }.to_h { |role|
                 [ role.to_sym, role.titleize ]
               }, hint: "Your role in the church.", required: true
end
