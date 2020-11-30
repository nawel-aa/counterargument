class Notification < ApplicationRecord
  # belongs_to :notifier, class_name: 'User'
  # belongs_to :notified, class_name: 'User'
  belongs_to :user
  belongs_to :argument
  validates :message, presence: true
end
