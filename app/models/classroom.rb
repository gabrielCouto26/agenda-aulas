class Classroom < ApplicationRecord
  belongs_to :subject, optional: true
  belongs_to :teacher, optional: true
  has_and_belongs_to_many :students
  has_one :class_detail, dependent: :destroy
end
