class User < ActiveRecord::Base
  before_save :ensure_authentication_token

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :authentication_token
  # attr_accessible :title, :body

  has_and_belongs_to_many :stocks
  has_and_belongs_to_many :erdates

  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followees, through: :relationships, source: :followee, :dependent => :destroy

  has_many :reverse_relationships, foreign_key: "followee_id",
           class_name:  "UserRelationship",
           dependent:   :destroy
  has_many :followers, through: :reverse_relationships, source: :follower, :dependent => :destroy

  has_many :beat_misses, :dependent => :destroy

  has_many :tweets, :dependent => :destroy

  has_one :profile, :dependent => :destroy

  def following?(other_user)
    relationships.where(followee_id: other_user.id).present?
  end

  def follow!(other_user)
    relationships.create!(followee_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by(followee_id: other_user.id).destroy
  end

  def watchEr?(erdate)
    if erdate.nil?
      false
    end
    erdates.where(:id => erdate.id).present?
  end

  def watchEr!(erdate)
    if (!watchEr?(erdate))
      erdates << erdate

      unless (self.stocks.include? erdate.stock)
        self.stocks << erdate.stock
      end
    end
  end

  def unwatchEr!(erdate)
    if (watchEr?(erdate))
      erdates.delete(erdate)
    end
  end

  def beatEr?(erdate)
    if erdate.nil?
      false
    end
    beat_misses.where(:erdate_id => erdate.id).present?
  end

  def beatEr!(erdate)
    if (!beatEr?(erdate))
      bm = BeatMiss.new()
      bm.user = self
      bm.erdate = erdate
      bm.beat!
      bm.save()

      erdate.beat_cnt = (erdate.beat_cnt || 0) + 1
      erdate.save()

      beat_misses << bm
    end
  end

  def missEr!(erdate)
    if (!beatEr?(erdate))
      bm = BeatMiss.new()
      bm.user = self
      bm.erdate = erdate
      bm.miss!
      bm.save()

      erdate.miss_cnt = (erdate.miss_cnt || 0) + 1
      erdate.save()

      beat_misses << bm
    end
  end

  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end

  def as_json(options=nil)
    super(:include => [:profile])
  end

  private

  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end
end
