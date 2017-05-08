

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
merchant = ['Starbucks', 'Llao Llao', 'Ding Tai Fung', 'Old Chang Kee', 'Nespresso']
merchant_code = ['ST001', 'L028', 'DTF012', 'OCK009', 'NS012']
item = ['Cup of Coffee', 'Petit Yogurt with 1 Topping', '$10 off Total Bill', '2 Curry Puffs', '5 Lungo Capsules']
value = [3, 2, 10, 2, 8]
expiry = ['10-Jul-2017', '5-May-2017', '1-Jun-2017', '30-May-2017', '28-April-2017']
category = ["F&B", "F&B", "F&B", "F&B", "F&B"]

limit = merchant.length

limit.times do |n|
  Reward.create(
    merchant: merchant.fetch(n),
    merchant_code: merchant_code.fetch(n),
    item: item.fetch(n),
    value: value.fetch(n),
    expiry: expiry.fetch(n),
    category: category.fetch(n)
  )
end
