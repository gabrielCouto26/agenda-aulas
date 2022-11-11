require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "create" do
    user = User.create(
      name: "gabriel",
      email: "gabriel@email.com",
      password: "1234",
      birth_date: "26/09/1996"
    )
    assert User.find(user.id).present?
    assert_equal User.find(user.id).name, "gabriel"
  end

  test "list empty" do
    users = User.all
    assert_empty users
  end

  test "list not empty" do
    User.create(
      name: "gabriel",
      email: "gabriel@email.com",
      password: "1234",
      birth_date: "26/09/1996"
    )
    users = User.all
    assert_not_empty users
    assert_equal users.first.name, "gabriel"
  end

  test "update" do
    user = User.create(
      name: "gabriel",
      email: "gabriel@email.com",
      password: "1234",
      birth_date: "26/09/1996"
    )
    user.update(name: "teste")
    assert_equal user.reload.name, "teste"
  end

  test "destroy" do
    user = User.create(
      name: "gabriel",
      email: "gabriel@email.com",
      password: "1234",
      birth_date: "26/09/1996"
    )
    user.destroy
    assert user.destroyed?
  end
end
