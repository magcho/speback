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
  twitter_uid: '0123456012341',
  twitter_id: 'example',
  icon_path: 'exampe.com'
)
User.create!(
  name:  "magcho1",
  twitter_uid: '012345601242',
  icon_path: 'exampe.com',
  twitter_id: 'example'
)
User.create!(
  name:  "magcho2",
  twitter_uid: '0123456012343',
  icon_path: 'exampe.com',
  twitter_id: 'example'
)
User.create!(
  name:  "magcho3",
  twitter_uid: '0123456012344',
  icon_path: 'exampe.com',
  twitter_id: 'example'
)


#slides
Slide.create!(
  user_id: 1,
  start_at: Time.zone.now,
  close_at: Time.zone.now + 2.hours,
  originfile_path: 'asdf'
)