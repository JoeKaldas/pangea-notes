FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "test-#{n.to_s.rjust(3,"0")}@sample.com" }
    password { "12345678" }
  end

  # Not used in this tutorial, but left to show an example of different user types
  # factory :admin do
  #   id {2}
  #   email {"test@admin.com"}
  #   password {"qwerty"}
  #   admin {true}
  # end
end
