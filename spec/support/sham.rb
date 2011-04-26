require "digest/sha1"
# Sham helpers

Sham.define do
  username { Faker::Internet.user_name }
  name     { Faker::Name.name }
  email    { Faker::Internet.email }
  title    { |index| "An example title #{index}" }
  body     { Faker::Lorem.paragraph }
  hash     { |index| Digest::SHA1.hexdigest(Time.now + "helloworld" + index) }
end
