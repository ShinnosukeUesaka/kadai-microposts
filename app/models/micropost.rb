class Micropost < ApplicationRecord
  belongs_to :user
  
  has_many :reverse_favorites, class_name: 'Favorite', foreign_key: :micropost_id, dependent: :destroy
  has_many :liking_users, through: :reverse_favorites, source: :user, dependent: :destroy
  
  validates :content, presence: true, length: { maximum: 255 }
end
