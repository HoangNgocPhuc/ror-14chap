class Micropost < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  scope :select_item, lambda {|following_ids| where :user_id => following_ids}
  scope :sort_by_time, ->{order created_at: :desc}

  mount_uploader :picture, PictureUploader

  validates :user, presence: true
  validates :content, presence: true,
    length: {maximum: Settings.micropost.content.maximum}
  validates :title, presence: true
  validate :picture_size

  private

  def picture_size
    errors.add :picture, I18n.t("microposts.model.picture_warning") if
      picture.size > Settings.micropost.picture.maximum.megabytes
  end
end
