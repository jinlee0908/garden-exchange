class Trade < ActiveRecord::Base
  belongs_to :item
  before_create :phone_num_integers_only
  validates :item_id, presence: true
  validates :name, presence: true
  validates :comment, presence: true,
                      length:   { maximum: 140, too_long: "%{count} characters
                                  is the maximum allowed." }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :trade_email, format: { with: VALID_EMAIL_REGEX }, allow_blank: true
  validates :phone_num,  
            format: { with: /\d/ },
            allow_blank: true
  validate :must_have_trade_email_or_phone_num


  state_machine initial: :new do
    state :new
    state :pending
    state :cancel
    state :complete

    event :request_made do
      transition :new => :pending
    end

    event :completed do
      transition :pending => :complete
    end

    event :cancel do
      transition :pending => :cancel
    end


    # state :new do
    #   def is_new?
    #     true
    #     # true if @item.save?
    #   end
    # end

    # state :pending do
    # def pending
    #   true if @trade.save? 
    #   end
    # end

   #  state :cancel do
   #    def 
   #    end
   #  end

   #  state :complete do
   #    def 
   #    end
   #  end    
   end


  private

  def must_have_trade_email_or_phone_num
    if self.trade_email.empty? && self.phone_num.empty?
      errors.add(:base, 'You must include an email or a phone number.')
    end 
  end

  def phone_num_integers_only
    unless self.phone_num.empty?
      self.phone_num = phone_num.gsub(/\D/,"")
    end
  end
end
