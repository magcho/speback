# coding: utf-8
class Slide < ApplicationRecord
  belongs_to :user
  # belongs_to :event スライドに必ずイベントがあるわけではないので指定しない
  has_many :pages
  has_secure_token
  default_scope -> { order(created_at: :desc) }
  mount_uploader :originfile_path, SlideUploader

  validates :title, presence: true
  validates :originfile_path, presence: true
  validates :summary, length: {maximum: 3000}
  validate :checkAfterCloseAt


  private
    # 開始時刻より終了時刻の方が後になっているか確認
    def checkAfterCloseAt
      if self.start_at == Time.local(0, 1, 1, 0, 0, 0, 0) 
        self.start_at = nil
      end

      if self.close_at == Time.local(0, 1, 1, 0, 0, 0, 0)
        self.close_at = nil
      end
      
      # errors.add(:close_at) unless self.start_at < self.close_at
      if self.start_at != nil and self.close_at != nil
          if self.start_at > self.close_at
            errors.add(:close_at, '開始時刻より過去に終了時刻を設定することはできません')
          end
      end
    end
end
