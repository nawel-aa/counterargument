class Argument < ApplicationRecord

  include AlgoliaSearch

  algoliasearch do
    attributes :content
  end

  belongs_to :user

  has_many :parent, class_name: 'Argument'
  has_many :children, class_name: 'Argument'
  has_many :tags, through: :tags_argument

  validates :content, presence: true
end
