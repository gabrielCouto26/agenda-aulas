require 'test_helper'

class AddressesControllerTest < ActionDispatch::IntegrationTest
  test "index empty" do
    get "/addresses"
    assert_response :success
    assert_empty JSON.parse(@response.body)["data"]
  end

  test "index not empty" do
    user = create_user
    address = Address.create(
      country: "Brasil",
      state: "RJ",
      city: "Rio de Janeiro",
      user_id: user.id
    )
    get "/addresses"
    assert_response :success
    assert_not_nil JSON.parse(@response.body)["data"].first
    assert_equal "Brasil", JSON.parse(@response.body)["data"].first["country"]
  end

  test "show" do
    user = create_user
    address = Address.create(
      country: "Brasil",
      state: "RJ",
      city: "Rio de Janeiro",
      user_id: user.id
    )
    get "/addresses/#{address.id}"
    assert_response :success
    assert_equal "Brasil", JSON.parse(@response.body)["data"]["country"]
  end

  test "create" do
    user = create_user
    post "/addresses", params: {
      address: {
        country: "Brasil",
        state: "RJ",
        city: "Rio de Janeiro",
        user_id: user.id
      }
    }
    assert_response :success
    assert_equal "Brasil", JSON.parse(@response.body)["data"]["country"]
  end

  test "update" do
    user = create_user
    address = Address.create(
      country: "Brasil",
      state: "RJ",
      city: "Rio de Janeiro",
      user_id: user.id
    )
    put "/addresses/#{address.id}", params: {
      address: {
        country: "Brasil",
        state: "SP",
        city: "São Paulo",
        user_id: user.id
      }
    }
    assert_response :success
    assert_equal "São Paulo", JSON.parse(@response.body)["data"]["city"]
  end
  
  test "destroy" do
    user = create_user
    address = Address.create(
      country: "Brasil",
      state: "RJ",
      city: "Rio de Janeiro",
      user_id: user.id
    )
    delete "/addresses/#{address.id}"
    assert_response :success
    assert_nil Address.where(id: address.id).first
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
