require 'test_helper'

class AddressTest < ActiveSupport::TestCase

  test "create" do
    user = create_user
    address = Address.create(
      country: "Brasil",
      state: "RJ",
      city: "Rio de Janeiro",
      user_id: user.id
    )
    assert Address.find(address.id).present?
    assert_equal Address.find(address.id).country, "Brasil"
  end

  test "list empty" do
    addresses = Address.all
    assert_empty addresses
  end

  test "list not empty" do
    user = create_user
    address = Address.create(
      country: "Brasil",
      state: "RJ",
      city: "Rio de Janeiro",
      user_id: user.id
    )
    addresses = Address.all
    assert_not_empty addresses
    assert_equal addresses.first.country, "Brasil"
  end

  test "update" do
    user = create_user
    address = Address.create(
      country: "Brasil",
      state: "RJ",
      city: "Rio de Janeiro",
      user_id: user.id
    )
    address.update(state: "São Paulo")
    assert_equal address.reload.state, "São Paulo"
  end

  test "destroy" do
    user = create_user
    address = Address.create(
      country: "Brasil",
      state: "RJ",
      city: "Rio de Janeiro",
      user_id: user.id
    )
    address.destroy
    assert address.destroyed?
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
