class Comment < ApplicationRecord
  # belongs_to :user
  belongs_to :page

  validates :text, presence: true, length: {maximum: 140}
  validates :page, presence: true
  validates :icon_url, presence: true
  validates :tweet_id, presence: true, uniqueness: true
end
