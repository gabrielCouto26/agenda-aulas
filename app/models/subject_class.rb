class SubjectClass < ApplicationRecord
  belongs_to :subject
  belongs_to :teacher
  has_many :students
  has_one :class_details
end
