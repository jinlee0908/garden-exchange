class Item < ActiveRecord::Base
  before_create { self.phone = phone.gsub(/\D/, "") } 

  validates :location, presence: true
  validate :must_have_email_or_phone
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, format: { with: VALID_EMAIL_REGEX }, allow_blank: true
  validate :phone, length: 10, message: "must include an area code", allow_blank: true

  def must_have_email_or_phone
    if self.email.empty? && self.phone.empty?
      errors.add(:base, 'You must include an email or a phone number.')
    end 
  end
end
