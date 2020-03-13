FactoryBot.define do
  factory :support_request do
    requester { nil }
    on_behalf_of { nil }
    message { "MyText" }
    offer { nil }
  end
end
