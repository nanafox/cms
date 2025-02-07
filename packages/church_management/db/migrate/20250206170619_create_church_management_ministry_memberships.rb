class CreateChurchManagementMinistryMemberships < ActiveRecord::Migration[8.0]
  def change
    create_table :church_management_ministry_memberships do |t|
      t.integer :role, null: false
      t.belongs_to :member, null: false, foreign_key: { :to_table => :church_management_members }
      t.belongs_to :ministry, null: false, foreign_key: { :to_table => :church_management_ministries }

      t.index [:ministry_id, :member_id], unique: true

      t.timestamps
    end
  end
end
