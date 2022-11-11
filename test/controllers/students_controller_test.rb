require 'test_helper'

class StudentsControllerTest < ActionDispatch::IntegrationTest
  test "index empty" do
    get "/students"
    assert_response :success
    assert_empty JSON.parse(@response.body)["data"]
  end

  test "index not empty" do
    user = create_user
    student = Student.create(
      formation_level: "Ensino superior completo",
      user_id: user.id
    )
    get "/students"
    assert_response :success
    assert_not_nil JSON.parse(@response.body)["data"].first
    assert_equal user.id, JSON.parse(@response.body)["data"].first["user_id"]
  end

  test "show" do
    user = create_user
    student = Student.create(
      formation_level: "Ensino superior completo",
      user_id: user.id
    )
    get "/students/#{student.id}"
    assert_response :success
    assert_equal user.id, JSON.parse(@response.body)["data"]["user_id"]
  end

  test "create" do
    user = create_user
    post "/students", params: {
      student: {
        formation_level: "Ensino superior completo",
        user_id: user.id
      }
    }
    assert_response :success
    assert_equal "Ensino superior completo", JSON.parse(@response.body)["data"]["formation_level"]
  end

  test "update" do
    user = create_user
    student = Student.create(
      formation_level: "Ensino superior completo",
      user_id: user.id
    )
    put "/students/#{student.id}", params: {
      student: {
        formation_level: "Ensino médio incompleto",
        user_id: user.id
      }
    }
    assert_response :success
    assert_equal "Ensino médio incompleto", JSON.parse(@response.body)["data"]["formation_level"]
  end
  
  test "destroy" do
    user = create_user
    student = Student.create(
      formation_level: "Ensino superior completo",
      user_id: user.id
    )
    delete "/students/#{student.id}"
    assert_response :success
    assert_nil Student.where(id: student.id).first
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
