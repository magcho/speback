FactoryBot.define do
  factory :event do
    name { "sample event" }
    start_at { "2020-05-10 03:59:17" }
    close_at { "2020-05-10 03:59:17" }
    url { "https://example.com" }
  end
end
