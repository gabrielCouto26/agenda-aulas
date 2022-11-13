require 'test_helper'

class TeacherTest < ActiveSupport::TestCase
  test "create" do
    user = create_user
    teacher = Teacher.create(
      teacher_since: "01/03/2018",
      domain: "História",
      experience: "Colégio Pedro II",
      user_id: user.id
    )
    assert Teacher.find(teacher.id).present?
    assert_not_nil Teacher.find(teacher.id)
  end

  test "list empty" do
    teachers = Teacher.all
    assert_empty teachers
  end

  test "list not empty" do
    user = create_user
    teacher = Teacher.create(
      user_id: user.id
    )
    teachers = Teacher.all
    assert_not_empty teachers
    assert_not_nil teachers.first
  end

  test "update" do
    user = create_user
    teacher = Teacher.create(
      domain: "História",
      user_id: user.id
    )
    teacher.update(domain: "Informática")
    assert_equal teacher.reload.domain, "Informática"
  end

  test "destroy" do
    user = create_user
    teacher = Teacher.create()
    teacher.destroy
    assert teacher.destroyed?
  end

  test "teacher has many classrooms" do
    user = create_user
    teacher = Teacher.create(user_id: user.id)
    subject = create_subject
    classroom1 = create_classroom(teacher.id, subject.id)
    classroom2 = create_classroom(teacher.id, subject.id)
    
    assert classroom1.save
    assert classroom2.save
    assert_not_empty teacher.classrooms
    assert_equal 2, teacher.classrooms.size
  end

  def create_user
    User.create(
      name: "gabriel",
      email: "gabriel@email.com",
      password: "1234",
      birth_date: "26/09/1996"
    )
  end

  def create_subject
    Subject.create(
      name: "História"
    )
  end

  def create_classroom(teacher_id, subject_id)
    Classroom.create(
      teacher_id: teacher_id,
      subject_id: subject_id
    )
  end
end
