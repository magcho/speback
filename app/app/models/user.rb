class User < ApplicationRecord
  has_many :Slides,
            class_name: "Slide",
            foreign_key: "user_id",
            dependent: :destroy

  validates(:name, presence: true)
  validates(:twitter_uid, presence: true)
  validates(:twitter_id, presence: true)
  validates(:icon_path, presence: true, length: {maximum: 255})

  before_save :get_fullsize_iconpath


  private
    #apiから取得できるiconpathは縮小版なのでoriginalのurlに変換する
    def get_fullsize_iconpath
      self.icon_path = icon_path.gsub('_normal','')
    end
end
