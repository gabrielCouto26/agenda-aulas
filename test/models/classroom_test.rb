require 'test_helper'

class ClassRoomTest < ActiveSupport::TestCase
  test "create" do
    teacher = create_teacher
    subject = create_subject
    classroom = Classroom.create(
      teacher_id: teacher.id,
      subject_id: subject.id
    )
    assert Classroom.find(classroom.id).present?
    assert_not_nil Classroom.find(classroom.id)
  end

  test "list empty" do
    classrooms = Classroom.all
    assert_empty classrooms
  end

  test "list not empty" do
    teacher = create_teacher
    subject = create_subject
    classroom = Classroom.create(
      teacher_id: teacher.id,
      subject_id: subject.id
    )
    classrooms = Classroom.all
    assert_not_empty classrooms
    assert_not_nil classrooms.first
  end

  # test "update" do
  #   teacher = create_teacher
  #   subject = create_subject
  #   classroom = Classroom.create(
  #     teacher_id: teacher.id,
  #     subject_id: subject.id
  #   )
  #   classroom.update(subject_id: 2)
  #   assert_equal classroom.reload.subject_id, 2
  # end

  test "destroy" do
    teacher = create_teacher
    subject = create_subject
    classroom = Classroom.create(
      teacher_id: teacher.id,
      subject_id: subject.id
    )
    classroom.destroy
    assert classroom.destroyed?
  end

  def create_teacher
    user = User.create(
      name: "gabriel",
      email: "gabriel@email.com",
      password: "1234",
      birth_date: "26/09/1996"
    )
    Teacher.create(
      user_id: user.id
    )
  end
  def create_subject
    Subject.create(
      name: "História"
    )
  end
end
