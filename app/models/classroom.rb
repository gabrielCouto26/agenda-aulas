class Classroom < ApplicationRecord
  belongs_to :subject, optional: true
  belongs_to :teacher, optional: true
  has_many :students
  has_one :class_details
end
