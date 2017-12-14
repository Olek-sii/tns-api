class Message < ApplicationRecord
  belongs_to :user

  scope :undone, -> { where(is_done: false) }
end
