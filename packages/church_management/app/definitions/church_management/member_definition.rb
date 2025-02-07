class ChurchManagement::MemberDefinition < ChurchManagement::ResourceDefinition
  action :add_to_ministry,
    interaction: ChurchManagement::MinistryMemberships::AddToMinistry,
    collection_record_action: false

  action :add_to_department,
    interaction: ChurchManagement::DepartmentMemberships::AddToDepartment,
    collection_record_action: false

  new_page_title "Add a Member Details"
  new_page_description "Register the new member to help track their activities in the church"

  edit_page_title "Edit member details"
  edit_page_description "Update the details for this member."

  field :first_name, as: :string, hint: "Enter the first name of the member."
  field :last_name, as: :string, hint: "Enter the last name of the member."
  field :middle_name, as: :string,
                      hint: "Enter the middle name of the member (optional)."
  field :date_of_birth,
    as: :date,
    hint: "Enter the date of birth of the member. " \
    "This will be used to set the member's chapel automatically."

  field :marital_status,
    choices: ChurchManagement::Member.marital_statuses.keys.to_h { |status|
      [status.to_sym, status.titleize]
    },
    hint: "The marital status of the member."

  field :employment_status,
    choices: ChurchManagement::Member.employment_statuses.keys.to_h { |status|
      [status.to_sym, status.titleize]
    },
    hint: "The employment status of the member."

  field :email_address,
    as: :email,
    hint: "Enter the email address of the member (optional)."

  field :residential_address,
    as: :string,
    hint: "Enter the residential address of the member."

  field :primary_phone_number,
    as: :phone,
    hint: "Enter the primary number of the member that can be reached."

  field :whatsapp_account_number,
    as: :phone,
    hint: "Enter the WhatsApp account number " \
    "(can be the same as primary phone number) of the member (optional)."

  display :marital_status, formatter: ->(value) { value.titlecase }
  display :employment_status, formatter: ->(value) { value.titlecase }

  search do |scope, query|
    scope.where(
      "first_name LIKE :q OR last_name LIKE :q OR middle_name LIKE :q",
      q: "%#{query}%",
    )
  end
end
