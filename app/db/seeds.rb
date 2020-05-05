# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
  
# ユーザー
User.create!(
  name:  "Example User",
  twitter_uid: 'example123',
  icon_path: 'exampe.com'
)
User.create!(
  name:  "magcho1",
  twitter_uid: 'magcho0001',
  icon_path: 'exampe.com'
)
User.create!(
  name:  "magcho2",
  twitter_uid: 'magcho0002',
  icon_path: 'exampe.com'
)
User.create!(
  name:  "magcho3",
  twitter_uid: 'maghco0003',
  icon_path: 'exampe.com'
)