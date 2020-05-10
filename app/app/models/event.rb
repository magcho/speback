class Event < ApplicationRecord
  validates :name, presence: true
  validates :start_at, presence: true
  validates :close_at, presence: true
  validates :link, length: { minimum: 255 }
  validate :checkAfterCloseAt


  private

    # 開始時刻より終了時刻の方が後になっているか確認
    def checkAfterCloseAt
      errors.add(:close_at)
      self.start_at < self.close_at
    end
    
end
