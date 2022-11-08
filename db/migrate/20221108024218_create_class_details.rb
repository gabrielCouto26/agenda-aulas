class CreateClassDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :class_details do |t|
      t.float :price
      t.datetime :schedule
      t.int :duration
      t.bool :online
      t.string :origin
      t.bool :available
      t.bool :active

      t.timestamps
    end
  end
end
