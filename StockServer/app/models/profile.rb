class Profile < ActiveRecord::Base
  attr_accessible :beat, :failure, :miss, :rank, :success, :username, :bullism, :avatar, :avatar_attributes

  # This method associates the attribute ":avatar" with a file attachment
  has_attached_file :avatar, :styles => {
      thumb: '100x100>',
      square: '200x200#',
      medium: '300x300>'
  },  :default_url => :default_url_by_bullism, :default_style => :square

  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  belongs_to :user

  private

  def default_url_by_bullism
    if self.bullism == 1
      'http://s3.amazonaws.com/stock-earning-cal/media/images/default/:style/missing_header_bull.png'
    else
      'http://s3.amazonaws.com/stock-earning-cal/media/images/default/:style/missing_header_bear.png'
    end
  end
end
