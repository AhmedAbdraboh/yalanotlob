class Gruop < ApplicationRecord
  belongs_to :user
  has_many :users
  has_many :members
end
