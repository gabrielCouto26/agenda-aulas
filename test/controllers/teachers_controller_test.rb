require 'test_helper'

class TeachersControllerTest < ActionDispatch::IntegrationTest
  test "index empty" do
    get "/teachers"
    assert_response :success
    assert_empty JSON.parse(@response.body)["data"]
  end

  test "index not empty" do
    user = create_user
    teacher = Teacher.create(
      user_id: user.id
    )
    get "/teachers"
    assert_response :success
    assert_not_nil JSON.parse(@response.body)["data"].first
    assert_equal user.id, JSON.parse(@response.body)["data"].first["user_id"]
  end

  test "show" do
    user = create_user
    teacher = Teacher.create(
      user_id: user.id
    )
    get "/teachers/#{teacher.id}"
    assert_response :success
    assert_equal user.id, JSON.parse(@response.body)["data"]["user_id"]
  end

  test "create" do
    user = create_user
    post "/teachers", params: {
      teacher: {
        teacher_since: "01/03/2018",
        domain: "História",
        experience: "Colégio Pedro II",
        user_id: user.id
      }
    }
    assert_response :success
    assert_equal "História", JSON.parse(@response.body)["data"]["domain"]
  end

  test "update" do
    user = create_user
    teacher = Teacher.create(
      user_id: user.id
    )
    put "/teachers/#{teacher.id}", params: {
      teacher: {
        teacher_since: "01/03/2018",
        domain: "Informática",
        experience: "Colégio Pedro II",
        user_id: user.id
      }
    }
    assert_response :success
    assert_equal "Informática", JSON.parse(@response.body)["data"]["domain"]
  end
  
  test "destroy" do
    user = create_user
    teacher = Teacher.create(
      user_id: user.id
    )
    delete "/teachers/#{teacher.id}"
    assert_response :success
    assert_nil Teacher.where(id: teacher.id).first
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
