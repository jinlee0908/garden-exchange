class ItemMailer < ActionMailer::Base
  default from: "do-not-reply@example.com"

  def item_confirmation_email(item)
    @item = item
    mail(to: @item.email, from: ENV["DOMAIN_SEND_FROM"], :subject => "Thanks for sharing the harvest!")
  end
end
