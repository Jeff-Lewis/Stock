class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  has_and_belongs_to_many :stocks
  has_and_belongs_to_many :erdates

  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followees, through: :relationships, source: :followee

  has_many :reverse_relationships, foreign_key: "followee_id",
           class_name:  "UserRelationship",
           dependent:   :destroy
  has_many :followers, through: :reverse_relationships, source: :follower

  def following?(other_user)
    relationships.find_by(followee_id: other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followee_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by(followee_id: other_user.id).destroy
  end

  def watchEr?(erdate)
    erdates.where(:id => erdate.id).present?
  end

  def watchEr!(erdate)
    if (!watchEr?(erdate))
      erdates << erdate
    end
  end

  def unwatchEr!(erdate)
    if (watchEr?(erdate))
      erdates.delete(erdate)
    end
  end
end
