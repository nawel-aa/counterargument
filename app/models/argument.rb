class Argument < ApplicationRecord
  # this will create an Argument index and add search capabilities to the Argument model:
  include AlgoliaSearch

  algoliasearch do
    # list of attributes used to build an Algolia record
    attributes :content
  end

  belongs_to :user
  has_many :tags, through: :tags_argument
  has_many :tags_argument

  # Gets all the relationships where you are the parent
  has_many :relationships_as_a_parent, class_name: 'ArgumentParentChildRelationship', foreign_key: :parent_id

  # Gets all the relationships where you are the child
  has_many :relationships_as_a_child, class_name: 'ArgumentParentChildRelationship', foreign_key: :child_id

  # Taking all the relationships where you are the child, getting the parent and calling it parents
  has_many :parents, through: :relationships_as_a_child, source: :parent
  # Taking all the relationships where you are the child, getting the parent and calling it children
  has_many :children, through: :relationships_as_a_parent, source: :child

  has_many :tags, through: :tags_argument
  has_many :notifications, dependent: :destroy
  has_many :votes, dependent: :destroy

  validates :content, presence: true
end
