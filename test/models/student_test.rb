require 'test_helper'

class StudentTest < ActiveSupport::TestCase
  test "create" do
    user = create_user
    student = Student.create(
      formation_level: "Ensino superior completo",
      user_id: user.id
    )
    assert Student.find(student.id).present?
    assert_not_nil Student.find(student.id)
  end

  test "list empty" do
    students = Student.all
    assert_empty students
  end

  test "list not empty" do
    user = create_user
    student = Student.create(
      user_id: user.id
    )
    students = Student.all
    assert_not_empty students
    assert_not_nil students.first
  end

  test "update" do
    user = create_user
    student = Student.create(
      formation_level: "Ensino superior completo",
      user_id: user.id
    )
    student.update(formation_level: "Ensino médio incompleto")
    assert_equal student.reload.formation_level, "Ensino médio incompleto"
  end

  test "destroy" do
    user = create_user
    student = Student.create()
    student.destroy
    assert student.destroyed?
  end

  def create_user
    User.create(
      name: "gabriel",
      email: "gabriel@email.com",
      password: "1234",
      birth_date: "26/09/1996"
    )
  end
end
