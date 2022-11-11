require 'test_helper'

class ClassDetailTest < ActiveSupport::TestCase
  test "create" do
    classroom = create_classroom
    class_detail = ClassDetail.create(
      price: 100.0,
      schedule: "11/11/2022",
      duration: 1,
      online: true,
      origin: "offered",
      available: true,
      active: false,
      classroom_id: classroom.id
    )
    assert ClassDetail.find(class_detail.id).present?
    assert_not_nil ClassDetail.find(class_detail.id)
  end

  test "list empty" do
    class_details = ClassDetail.all
    assert_empty class_details
  end

  test "list not empty" do
    classroom = create_classroom
    class_detail = ClassDetail.create(
      price: 100.0,
      schedule: "11/11/2022",
      duration: 1,
      online: true,
      origin: "offered",
      available: true,
      active: false,
      classroom_id: classroom.id
    )
    class_details = ClassDetail.all
    assert_not_empty class_details
    assert_not_nil class_details.first
  end

  test "update" do
    classroom = create_classroom
    class_detail = ClassDetail.create(
      price: 100.0,
      schedule: "11/11/2022",
      duration: 1,
      online: true,
      origin: "offered",
      available: true,
      active: false,
      classroom_id: classroom.id
    )
    class_detail.update(online: false)
    assert_equal class_detail.reload.online, false
  end

  test "destroy" do
    classroom = create_classroom
    class_detail = ClassDetail.create(
      price: 100.0,
      schedule: "11/11/2022",
      duration: 1,
      online: true,
      origin: "offered",
      available: true,
      active: false,
      classroom_id: classroom.id
    )
    class_detail.destroy
    assert class_detail.destroyed?
  end

  def create_classroom
    user = User.create(
      name: "gabriel",
      email: "gabriel@email.com",
      password: "1234",
      birth_date: "26/09/1996"
    )
    teacher = Teacher.create(
      user_id: user.id
    )
    subject = Subject.create(
      name: "História"
    )
    Classroom.create(
      teacher_id: teacher.id,
      subject_id: subject.id
    )
  end
end
