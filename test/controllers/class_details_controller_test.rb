require 'test_helper'

class ClassDetailsControllerTest < ActionDispatch::IntegrationTest
  test "index empty" do
    get "/class_details"
    assert_response :success
    assert_empty JSON.parse(@response.body)["data"]
  end

  test "index not empty" do
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
    get "/class_details"
    assert_response :success
    assert_not_nil JSON.parse(@response.body)["data"].first
    assert_equal classroom.id, JSON.parse(@response.body)["data"].first["classroom_id"]
  end

  test "show" do
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
    get "/class_details/#{class_detail.id}"
    assert_response :success
    assert_equal classroom.id, JSON.parse(@response.body)["data"]["classroom_id"]
  end

  test "create" do
    classroom = create_classroom
    post "/class_details", params: {
      class_detail: {
        price: 100.0,
        schedule: "11/11/2022",
        duration: 1,
        online: true,
        origin: "offered",
        available: true,
        active: false,
        classroom_id: classroom.id
      }
    }
    assert_response :success
    assert_equal classroom.id, JSON.parse(@response.body)["data"]["classroom_id"]
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
    put "/class_details/#{class_detail.id}", params: {
      class_detail: {
        price: 50.0,
        schedule: "11/11/2022",
        duration: 1,
        online: true,
        origin: "offered",
        available: true,
        active: false,
        classroom_id: classroom.id
      }
    }
    assert_response :success
    assert_equal 50.0, JSON.parse(@response.body)["data"]["price"]
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
    delete "/class_details/#{class_detail.id}"
    assert_response :success
    assert_nil ClassDetail.where(id: class_detail.id).first
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
