class CreateChurchManagementDepartmentMemberships < ActiveRecord::Migration[8.0]
  def change
    create_table :church_management_department_memberships do |t|
      t.belongs_to :member, null: false,
                            foreign_key: { to_table: :church_management_members }
      t.belongs_to :department, null: false,
                                foreign_key: { to_table: :church_management_departments }
      t.integer :role, null: false

      t.index [:member_id, :department_id], unique: true
      t.timestamps
    end
  end
end
