require 'test_helper'

class SubjectTest < ActiveSupport::TestCase
  test "create" do
    subject = Subject.create(
      name: "História"
    )
    assert Subject.find(subject.id).present?
    assert_equal "História", Subject.find(subject.id).name
  end

  test "list empty" do
    subjects = Subject.all
    assert_empty subjects
  end

  test "list not empty" do
    subject = Subject.create()
    subjects = Subject.all
    assert_not_empty subjects
    assert_not_nil subjects.first
  end

  test "update" do
    subject = Subject.create(
      name: "História"
    )
    subject.update(name: "Informática")
    assert_equal subject.reload.name, "Informática"
  end

  test "destroy" do
    subject = Subject.create()
    subject.destroy
    assert subject.destroyed?
  end
end
