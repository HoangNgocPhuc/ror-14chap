class Micropost < ApplicationRecord
  belongs_to :user

  scope :select_item, -> id{where "user_id = ?", id}
  scope :sort_by_time, ->{order created_at: :desc}

  mount_uploader :picture, PictureUploader

  validates :user, presence: true
  validates :content, presence: true,
    length: {maximum: Settings.micropost.content.maximum}
  validate :picture_size

  private

  def picture_size
    errors.add :picture, I18n.t("microposts.model.picture_warning") if
      picture.size > Settings.micropost.picture.maximum.megabytes
  end
end
