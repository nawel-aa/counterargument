class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :argument

  validates :positive, presence: true
  
  scope :source, ->(arg_id = -1) { where("argument_id = ? and category = 'source'", arg_id).size }
  scope :funny, ->(arg_id = -1) { where("argument_id = ? and category = 'funny'", arg_id).size }
  scope :concise, ->(arg_id = -1) { where("argument_id = ? and category = 'concise'", arg_id).size }
  scope :user_upvotes, ->(user_id = -1) { where("user_id = ?", user_id).size }
end
