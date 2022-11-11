class User < ApplicationRecord
  has_many :profile
  has_one :teacher
  has_one :student
  has_one :address
end
