class CreateTeachers < ActiveRecord::Migration[5.2]
  def change
    create_table :teachers do |t|
      t.string :formation_level
      t.string :domain, null: false
      t.text :experience
      t.date :teacher_since
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
