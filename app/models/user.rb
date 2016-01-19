class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :age, numericality: { grater_than_or_equal_to: 0 }
  has_secure_password
  has_many :microposts
  has_many :favorites
  has_many :favorite_microposts,
           through: :favorites,
           source: :micropost,
           class_name: "Micropost"
  has_many :following_relationships, class_name:  "Relationship",
                                     foreign_key: "follower_id",
                                     dependent:   :destroy
  has_many :following_users, through: :following_relationships, source: :followed
  has_many :follower_relationships, class_name:  "Relationship",
                                    foreign_key: "followed_id",
                                    dependent:   :destroy
  has_many :follower_users, through: :follower_relationships, source: :follower
  
  def follow(other_user)
    following_relationships.find_or_create_by(followed_id: other_user.id)
  end
  def unfollow(other_user)
    following_relationship = following_relationships.find_by(followed_id: other_user.id)
    following_relationship.destroy if following_relationship
  end
  def following?(other_user)
    following_users.include?(other_user)
  end
  def feed_items
    Micropost.where(user_id: following_user_ids + [self.id])
  end
  def favorite(micropost)
    favorites.find_or_create_by(micropost_id: micropost.id)
  end
  def unfavorite(other_micropost)
    favorite_micropost = favorites.find_by(micropost_id: other_micropost.id)
    favorite_micropost.destroy if favorite_micropost
  end
  def favor?(micropost)
    #binding.pry
    favorites.exists?(micropost_id: micropost.id)
  end
end