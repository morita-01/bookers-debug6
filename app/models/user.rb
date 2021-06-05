class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  attachment :profile_image
  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  # foreign_key（FK）には、@user.reverse_of_relationshipsとした際に「@user.idがfollower_idなのかfollowed_idなのか」を指定します。この場合はfollowed_id
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # @user.booksのように、@user.followersで、
  # そのユーザがフォローしている人orフォローされている人の一覧を出したいこの場合はfollowerつまりフォローされている人
  has_many :followers, through: :reverse_of_relationships, source: :follower
  #こちらはuser.idはfollower_id
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  #こちらはfollowedつまりフォローしている人
  has_many :followings, through: :relationships, source: :followed
  
  def follow(user_id)
    relationships.create(followed_id: user_id)
    #binding.pry
  end
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end
  def following?(user)
    followings.include?(user)
  end
  
  
  validates :name, uniqueness: true, length: {minimum: 2,maximum: 20}
  validates :introduction, length: {maximum: 50}
  

end
