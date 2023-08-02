class Book < ApplicationRecord
  has_one_attached :image
  has_many :favorites, dependent: :destroy
  belongs_to :user
  has_many :book_comments, dependent: :destroy
  validates :title, presence: true
  validates :body, length:{maximum:200}, presence:true

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end

