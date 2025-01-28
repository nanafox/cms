class CreateRoles < ActiveRecord::Migration[8.0]
  def change
    create_table :roles do |t|
      t.string :name, null: false
      t.belongs_to :roleable, polymorphic: true, index: { unique: true }

      t.timestamps
    end
  end
end
