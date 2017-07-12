class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :micropost

  validates :user, presence: true
  validates :micropost, presence: true
  validates :content, presence: true

  def belong_to_user user
    self.user == user
  end
end
