require 'test_helper'

class SubjectsControllerTest < ActionDispatch::IntegrationTest
  test "index empty" do
    get "/subjects"
    assert_response :success
    assert_empty JSON.parse(@response.body)["data"]
  end

  test "index not empty" do
    subject = Subject.create(
      name: "História"
    )
    get "/subjects"
    assert_response :success
    assert_not_nil JSON.parse(@response.body)["data"].first
    assert_equal "História", JSON.parse(@response.body)["data"].first["name"]
  end

  test "show" do
    subject = Subject.create(
      name: "História"
    )
    get "/subjects/#{subject.id}"
    assert_response :success
    assert_equal "História", JSON.parse(@response.body)["data"]["name"]
  end

  test "create" do
    post "/subjects", params: {
      subject: {
        name: "História"
      }
    }
    assert_response :success
    assert_not_nil JSON.parse(@response.body)["data"]
    assert_equal "História", JSON.parse(@response.body)["data"]["name"]
  end

  test "update" do
    subject = Subject.create(
      name: "História"
    )
    put "/subjects/#{subject.id}", params: {
      subject: {
        name: "Informática"
      }
    }
    assert_response :success
    assert_equal "Informática", JSON.parse(@response.body)["data"]["name"]
  end
  
  test "destroy" do
    subject = Subject.create(
      name: "História"
    )
    delete "/subjects/#{subject.id}"
    assert_response :success
    assert_nil Subject.where(id: subject.id).first
  end
end
