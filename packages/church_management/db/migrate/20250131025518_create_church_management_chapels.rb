class CreateChurchManagementChapels < ActiveRecord::Migration[8.0]
  def change
    create_table :church_management_chapels do |t|
      t.string :name, null: false
      t.string :color, null: false
      t.integer :quarter, null: false

      t.timestamps
    end
  end
end
