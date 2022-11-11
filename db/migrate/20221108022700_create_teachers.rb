class CreateTeachers < ActiveRecord::Migration[5.2]
  def change
    create_table :teachers do |t|
      t.date :teacher_since
      t.string :domain
      t.text :experience
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
