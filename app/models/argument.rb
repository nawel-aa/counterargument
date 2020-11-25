class Argument < ApplicationRecord

  # this will create an Argument index and add search capabilities to the Argument model:
  include AlgoliaSearch

  algoliasearch do
    # list of attribute used to build an Algolia record
    attributes :content
      attribute :user do
        { name: user.nickname, id: user.id, email: user.email }
      end
  end

  belongs_to :user

  has_many :parent, class_name: 'Argument'
  has_many :children, class_name: 'Argument'
  has_many :tags, through: :tags_argument

  validates :content, presence: true
end
