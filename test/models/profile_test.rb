require 'test_helper'

class ProfileTest < ActiveSupport::TestCase
  test "create" do
    user = create_user
    profile = Profile.create(
      user_id: user.id
    )
    assert Profile.find(profile.id).present?
    assert_not_nil Profile.find(profile.id)
  end

  test "list empty" do
    profiles = Profile.all
    assert_empty profiles
  end

  test "list not empty" do
    user = create_user
    profile = Profile.create(
      user_id: user.id
    )
    profiles = Profile.all
    assert_not_empty profiles
    assert_not_nil profiles.first
  end

  test "update" do
    user = create_user
    profile = Profile.create(
      _type: 1,
      user_id: user.id
    )
    profile.update(_type: 2)
    assert_equal profile.reload._type, 2
  end

  test "destroy" do
    user = create_user
    profile = Profile.create()
    profile.destroy
    assert profile.destroyed?
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
