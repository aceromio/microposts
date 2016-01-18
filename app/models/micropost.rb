class Micropost < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  belongs_to :user
  has_many :favored_users,
           through: :favorites,
           source: :user,
           class_name:'User'
  has_many :favorites
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
end
