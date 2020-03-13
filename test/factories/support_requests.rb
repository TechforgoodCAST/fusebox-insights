FactoryBot.define do
  factory :support_request do
    requester
    on_behalf_of { nil }
    message { "MyText" }
    offer
    project
  end
end
