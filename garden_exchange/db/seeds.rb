# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Seeding the Category model with some test data - this only seeds the development 
# env not the test one.

test_categories = %w{Category? Artichokes Asparagus Beans Beets Broccoli
              Cabbage Carrots Cauliflower Celery Chard Collards Corn
              Cucumbers Eggplant Garlic Kale Kohlrabi Leeks Lettuce Melons
              Mushrooms Onions Parsley Parsnips Peas Peppers Potatos Pumpkins
              Radishes Rhubarb Shallots Spinach Squash Tomatoes Other}

Category.delete_all # clean out what is in there now

test_categories.each do |i|
  img = 100
  Category.create(category: i, image_id: img)
  img =+ 1
end
