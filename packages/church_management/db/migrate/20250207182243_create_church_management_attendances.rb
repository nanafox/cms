class CreateChurchManagementAttendances < ActiveRecord::Migration[8.0]
  def change
    create_table :church_management_attendances do |t|
      t.belongs_to :member, null: false,
        foreign_key: {to_table: :church_management_members}
      t.date :date, null: false
      t.integer :status, null: false
      t.belongs_to :recorder, null: false, foreign_key: {to_table: :users}

      t.index [:date, :member_id], unique: true  # mark attendance once only
      t.timestamps
    end
  end
end
