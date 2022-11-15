class AddClassroomName < ActiveRecord::Migration[5.2]
  def change
    add_column :classrooms, :name, :string
  end
end
