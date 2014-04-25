FactoryGirl.define do
  factory :item do
    category_id 16
    name "Curly"
    description "Yummy and good"
    location "19th and Pettygrove "
    email "example@example.com"
    phone ""
  end

  factory :trade do
    name "Tipsy"
    trade_email "tipsy@spider.com"
    phone_num "503 123-4567"
    comment "tipsy is cool"
    item
  end
end