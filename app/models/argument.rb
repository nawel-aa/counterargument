class Argument < ApplicationRecord

  # this will create an Argument index and add search capabilities to the Argument model:
  include AlgoliaSearch

  algoliasearch do
    # list of attribute used to build an Algolia record
    attributes :content
  end

  belongs_to :user

  has_many :parents, class_name: 'Argument'
  has_many :children, class_name: 'Argument'
  has_many :tags, through: :tags_argument
  has_many :notifications

  validates :content, presence: true
end
