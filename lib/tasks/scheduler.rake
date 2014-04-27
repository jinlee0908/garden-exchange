namespace :scheduler do

  desc "This task is called by the Heroku scheduler add-on and expires items that are 7 days old"
  task :expire_items => :environment do 
    expire_these_items = Item.where("state = ? AND created_at <= ?", :active, ENV['EXPIRATION_DAYS'].to_i.days.ago)
    expire_these_items.each do |i|
      i.fire_state_event(:cancel)
    end
  end

  desc "This task is called by the Heroku scheduler add-on and expires trades that are 7 days old"
  task :expire_trades => :environment do 
    expire_these_trades = Trade.where("state = ? AND created_at <= ?", :active, ENV['EXPIRATION_DAYS'].to_i.days.ago)
    expire_these_trades.each do |i|
      i.fire_state_event(:cancel)
    end
  end
end
