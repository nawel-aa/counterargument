class Argument < ApplicationRecord
  belongs_to :user

  has_many :parent, class_name: 'Argument'
  has_many :children, class_name: 'Argument'
  has_many :tags, through: :tags_argument

  validates :content, presence: true
end
