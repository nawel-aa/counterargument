class Tag < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :tags_argument
  has_many :arguments, through: :tags_argument
end
