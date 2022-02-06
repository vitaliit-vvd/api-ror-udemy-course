# frozen_string_literal: true

FactoryBot.define do
  factory :article do
    title { 'MyString' }
    content { 'MyText' }
    slug { 'MyString' }
  end
end
