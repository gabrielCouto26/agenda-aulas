class ClassDetail < ApplicationRecord
  belongs_to :classroom
  # origin: offered | requested
end
