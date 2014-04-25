class TradeMailer < ActionMailer::Base
  default from: "do-not-reply@example.com"

  def request_email(item, trade)
    @item = item
    @trade = trade
    mail(to: @item.email, from: ENV["DOMAIN_SEND_FROM"], :subject => "A request for your harvest!")
  end
end
