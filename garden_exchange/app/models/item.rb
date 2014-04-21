class Item < ActiveRecord::Base
  belongs_to :category
  has_many :trades
  geocoded_by :location
  reverse_geocoded_by :latitude, :longitude 
  after_validation :geocode
  attr_encrypted :email, key: ENV['TOKEN_KEY']
  has_attached_file :image, 
                    :styles => { :medium => ["300x300>", :png], :thumb => ["100x100", :png] }, 
                    :default_url => ActionController::Base.helpers.asset_path('missing.png')
                    # :s3_permissions => :private
  
  before_create :phone_integers_only

  validates :category_id, presence: true
  validates :location, presence: true
  validates :description, 
            presence: true,
            length: { maximum: 140, too_long: "%{count} characters is the maximum allowed." }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, format: { with: VALID_EMAIL_REGEX }, allow_blank: true
  validates :phone,  
            format: { with: /\d/ },
            allow_blank: true
  validate :must_have_email_or_phone
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  # validates_attachment_size :image, :size => { :in => 0...10.kilobytes }

  # state machine implementation.
  state_machine :state, initial: :active do

    event :offer_made do # user
      transition :active => :pending 
    end

    event :cancel do
      # add something here to delete aws image
      transition all - [:active, :pending] => :inactive
    end

  end

  def self.search(category_id)
    if category_id
      where('category_id = ?', "#{category_id}")
    else
      scoped
    end
  end


  private

    def must_have_email_or_phone
      if self.email.empty? && self.phone.empty?
        errors.add(:base, 'You must include an email or a phone number.')
      end 
    end

    def phone_integers_only
      unless self.phone.empty?
        self.phone = phone.gsub(/\D/,"")
      end
    end
end
