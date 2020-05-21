FactoryBot.define do
  factory :comment do
    text { "MyString" }
    user { nil }
    page { nil }
  end
end
