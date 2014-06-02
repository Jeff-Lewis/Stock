class Tweet < ActiveRecord::Base
  attr_accessible :content, :stock_id, :user_id, :erdate_id, :image, :image_attributes

  # This method associates the attribute ":image" with a file attachment
  has_attached_file :image, :styles => {
      thumb: '200x200>',
      medium: '300x400#',
      large: '600x800>'
  },  :default_style => :medium

  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  belongs_to :user, dependent: :destroy
  belongs_to :stock, dependent: :destroy
  belongs_to :erdate, dependent: :destroy

  def mediumImageUrl
    #URI(request.url) + this.attachment_name.url
    if image.url(:medium).include? "missing"
      ""
    else
      ActionController::Base.helpers.image_path image.url(:medium)
    end
  end

  def largeImageUrl
    #URI(request.url) + this.attachment_name.url
    if image.url(:large).include? "missing"
      ""
    else
      ActionController::Base.helpers.image_path image.url(:large)
    end
  end

  def as_json(options=nil)
    super(:methods => :mediumImageUrl)
  end
end
