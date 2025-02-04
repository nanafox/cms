class ChurchManagement::MemberPolicy < ChurchManagement::ResourcePolicy
  # Core actions

  def create?
    true
  end

  def read?
    true
  end

  # Core attributes

  def permitted_attributes_for_create
    [
      :first_name, :last_name, :middle_name, :date_of_birth, :marital_status,
      :email_address, :residential_address, :primary_phone_number,
      :whatsapp_account_number, :employment_status
    ]
  end

  def permitted_attributes_for_read
    [
      :first_name, :last_name, :middle_name, :date_of_birth, :marital_status,
      :email_address, :residential_address, :primary_phone_number,
      :whatsapp_account_number, :employment_status
    ]
  end

  def permitted_attributes_for_index
    [:full_name, :marital_status, :primary_phone_number, :employment_status]
  end

  # Associations

  def permitted_associations
    %i[]
  end
end
