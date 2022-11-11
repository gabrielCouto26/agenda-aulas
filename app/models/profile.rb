class Profile < ApplicationRecord
  belongs_to :user
  # field type: 1 - Student, 2 - Teacher, 3 - Student e Teacher
end
