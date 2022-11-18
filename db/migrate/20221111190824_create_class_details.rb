class CreateClassDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :class_details do |t|
      t.datetime :start_date
      t.float :price
      t.integer :class_duration
      t.integer :end_expectation
      t.boolean :online
      t.boolean :available
      t.references :classroom, foreign_key: true

      t.timestamps
    end
  end
end
