class ProfileDefinition < ::ResourceDefinition
  new_page_title "Complete your profile to continue"
  new_page_description "Ensure you provide the correct information. " \
                       "Your role will determine what you are allowed to " \
                       "access and responsible for."

  field :name,
        hint: "Enter your full name. This is how other users will know you."

  field :role, choices: User.roles.to_h { |role|
           [role.to_sym, role.titleize]
         }, hint: "Your role in the church.", required: true

  field :chapel, choices: ChurchManagement::Chapel.names.to_h { |name|
             [name.to_sym, name.titleize]
           }, hint: "Select your chapel.", required: true
end
