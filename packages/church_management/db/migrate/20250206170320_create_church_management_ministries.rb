class CreateChurchManagementMinistries < ActiveRecord::Migration[8.0]
  def change
    create_table :church_management_ministries do |t|
      t.string :name, null: false, index: {unique: true}
      t.string :description, null: false

      t.timestamps
    end
  end
end
