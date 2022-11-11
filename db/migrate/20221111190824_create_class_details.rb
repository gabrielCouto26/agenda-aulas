class CreateClassDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :class_details do |t|
      t.float :price
      t.datetime :schedule
      t.integer :duration
      t.boolean :online
      t.string :origin
      t.boolean :available
      t.boolean :active
      t.references :classroom, foreign_key: true

      t.timestamps
    end
  end
end
