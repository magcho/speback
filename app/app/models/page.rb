class Page < ApplicationRecord
  belongs_to :slide
  has_many :comments
  has_many :page_moves
  mount_uploader :img, PageUploader

  validates :page_num, presence: true
end
