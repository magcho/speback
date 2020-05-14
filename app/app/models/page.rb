class Page < ApplicationRecord
  belongs_to :slide
  mount_uploader :img, PageUploader

  validates :page_num, presence: true
end
