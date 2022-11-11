require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "index empty" do
    get "/users"
    assert_response :success
    assert_empty JSON.parse(@response.body)["data"]
  end

  test "index not empty" do
    user = User.create(
      name: "gabriel",
      email: "gabriel@email.com",
      password: "1234",
      birth_date: "26/09/1996"
    )
    get "/users"
    assert_response :success
    assert_not_nil JSON.parse(@response.body)["data"].first
    assert_equal "gabriel", JSON.parse(@response.body)["data"].first["name"]
  end

  test "show" do
    user = User.create(
      name: "gabriel",
      email: "gabriel@email.com",
      password: "1234",
      birth_date: "26/09/1996"
    )
    get "/users/#{user.id}"
    assert_response :success
    assert_equal "gabriel", JSON.parse(@response.body)["data"]["name"]
  end

  test "create" do
    post "/users", params: {
      user: {
        name: "gabriel",
        email: "gabriel@email.com",
        password: "1234",
        birth_date: "26/09/1996"
      }
    }
    assert_response :success
    assert_equal "gabriel", JSON.parse(@response.body)["data"]["name"]
  end

  test "update" do
    user = User.create(
      name: "gabriel",
      email: "gabriel@email.com",
      password: "1234",
      birth_date: "26/09/1996"
    )
    put "/users/#{user.id}", params: {
      user: {
        name: "gabriel couto",
        email: "gabriel@email.com",
        password: "1234",
        birth_date: "26/09/1996"
      }
    }
    assert_response :success
    assert_equal "gabriel couto", JSON.parse(@response.body)["data"]["name"]
  end
  
  test "destroy" do
    user = User.create(
      name: "gabriel",
      email: "gabriel@email.com",
      password: "1234",
      birth_date: "26/09/1996"
    )
    delete "/users/#{user.id}"
    assert_response :success
    assert_nil User.where(id: user.id).first
  end
end
