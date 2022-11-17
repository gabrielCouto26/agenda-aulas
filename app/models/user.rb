class User < ApplicationRecord
  has_many :profile, dependent: :destroy
  has_one :teacher, dependent: :destroy
  has_one :student, dependent: :destroy
  has_one :address, dependent: :destroy
end
