require 'test_helper'

class ClassroomsControllerTest < ActionDispatch::IntegrationTest
  test "index empty" do
    get "/classrooms"
    assert_response :success
    assert_empty JSON.parse(@response.body)["data"]
  end

  test "index not empty" do
    teacher = create_teacher
    subject = create_subject
    classroom = Classroom.create(
      teacher_id: teacher.id,
      subject_id: subject.id
    )
    get "/classrooms"
    assert_response :success
    assert_not_nil JSON.parse(@response.body)["data"].first
    assert_equal teacher.id, JSON.parse(@response.body)["data"].first["teacher_id"]
  end

  test "show" do
    teacher = create_teacher
    subject = create_subject
    classroom = Classroom.create(
      teacher_id: teacher.id,
      subject_id: subject.id
    )
    get "/classrooms/#{classroom.id}"
    assert_response :success
    assert_equal teacher.id, JSON.parse(@response.body)["data"]["teacher_id"]
  end

  test "create" do
    teacher = create_teacher
    subject = create_subject
    post "/classrooms", params: {
      classroom: {
        teacher_id: teacher.id,
        subject_id: subject.id
      }
    }
    assert_response :success
    assert_equal teacher.id, JSON.parse(@response.body)["data"]["teacher_id"]
  end

  test "student can create classroom" do
    student = create_student
    subject = create_subject
    post "/students/#{student.id}/classrooms", params: {
      classroom: {
        subject_id: subject.id
      }
    }
    assert_response :success
    assert_not_nil student.classrooms.where(id: 1)
  end

  # test "update" do
  #   teacher = create_teacher
  #   subject = create_subject
  #   classroom = Classroom.create(
  #     teacher_id: teacher.id,
  #     subject_id: subject.id
  #   )
  #   put "/classrooms/#{classroom.id}", params: {
  #     classroom: {
  #       teacher_id: teacher.id,
  #       subject_id: subject.id
  #     }
  #   }
  #   assert_response :success
  #   assert_equal "Ensino médio incompleto", JSON.parse(@response.body)["data"]["formation_level"]
  # end
  
  test "destroy" do
    teacher = create_teacher
    subject = create_subject
    classroom = Classroom.create(
      teacher_id: teacher.id,
      subject_id: subject.id
    )
    delete "/classrooms/#{classroom.id}"
    assert_response :success
    assert_nil Classroom.where(id: classroom.id).first
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
  def create_student
    user = User.create(
      name: "gabriel",
      email: "gabriel@email.com",
      password: "1234",
      birth_date: "26/09/1996"
    )
    Student.create(
      user_id: user.id
    )
  end
  def create_subject
    Subject.create(
      name: "História"
    )
  end
end
