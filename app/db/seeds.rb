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
  icon_path: 'https://pbs.twimg.com/profile_images/1111729635610382336/_65QFl7B.png'
)
User.create!(
  name:  "magcho1",
  twitter_uid: '012345601242',
  icon_path: 'https://pbs.twimg.com/profile_images/1111729635610382336/_65QFl7B.png',
  twitter_id: 'example'
)
User.create!(
  name:  "magcho2",
  twitter_uid: '0123456012343',
  icon_path: 'https://pbs.twimg.com/profile_images/1111729635610382336/_65QFl7B.png',
  twitter_id: 'example'
)
User.create!(
  name:  "magcho3",
  twitter_uid: '0123456012344',
  icon_path: 'https://pbs.twimg.com/profile_images/1111729635610382336/_65QFl7B.png',
  twitter_id: 'example'
)


#slides
Slide.create!(
  user_id: 1,
  start_at: Time.zone.now,
  close_at: Time.zone.now + 2.hours,
  originfile_path: 'asdf'
)

#events
Event.create!(
  name: 'サンプルカンファレンス',
  start_at: Time.zone.now + 2.hours,
  close_at: Time.zone.now + 3.hours,
  link: 'https://cookpad.connpass.com/event/173851/',
  coverimg_path: 'cover.png'
)

#hashtag
Hashtag.create!(
  name: 'sampleConf',
  event_id: 1
)
Hashtag.create!(
  name: 'sample-conf',
  event_id: 1
)
Hashtag.create!(
  name: 'サンプルカンファレンス',
  event_id: 1
)