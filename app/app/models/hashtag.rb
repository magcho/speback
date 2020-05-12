class Hashtag < ApplicationRecord
  belongs_to :event
  default_scope -> { order(created_at: :desc) }
  
  validates :name, presence: true
  validates :event_id, presence: true
end
