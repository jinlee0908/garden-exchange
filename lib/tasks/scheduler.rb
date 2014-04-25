desc "This task is called by the Heroku scheduler add-on and expires items that are 7 says old"
task :expire_items => :environment do 
  expire_these_items = Item.where( state: 'active').where("created_at <= #{7.days.ago}")
  expire_items.each do |i|
    i.fire_state_event(:cancel)
  end
end
