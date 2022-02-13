# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    content { 'MyText' }
    article { nil }
    user { nil }
  end
end
