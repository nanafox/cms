class CreateChurchManagementMembers < ActiveRecord::Migration[8.0]
  def change
    create_table :church_management_members do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :middle_name, null: true
      t.date :date_of_birth, null: false
      t.integer :marital_status, null: false
      t.string :email_address, null: true
      t.string :residential_address, null: false
      t.string :primary_phone_number, null: false
      t.string :whatsapp_account_number, null: true
      t.integer :employment_status, null: false
      t.belongs_to :creator, null: false, foreign_key: {to_table: :users}
      t.belongs_to :chapel, null: false,
        foreign_key: {to_table: :church_management_chapels}

      t.timestamps
    end
  end
end
