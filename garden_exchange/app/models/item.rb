class Item < ActiveRecord::Base
  belongs_to :category

  geocoded_by :location #this can be a method to pull in... 
  after_validation :geocode, :if => :location_changed?
  before_create :phone_integers_only

  validates :category_id, presence: true
  validates :location, presence: true
  validates :description, length: { maximum: 140, too_long: "%{count} characters is the maximum allowed." }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, format: { with: VALID_EMAIL_REGEX }, allow_blank: true
  validates :phone,  
            format: { with: /\d/ },
            allow_blank: true
  validate :must_have_email_or_phone

  def self.search(search,category_id)
    if search
      where('latitude = ?', "#{search}")
      where('longitude = ?', "#{search}")
      where('miles = ?', "#{search}")
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
