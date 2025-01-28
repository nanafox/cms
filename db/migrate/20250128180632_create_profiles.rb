class CreateProfiles < ActiveRecord::Migration[8.0]
  def change
    create_table :profiles do |t|
      t.string :name, null: false
      t.belongs_to :user, null: false, foreign_key: true,
                          index: { unique: true }
      t.string :phone_number, null: false

      t.timestamps
    end
  end
end
