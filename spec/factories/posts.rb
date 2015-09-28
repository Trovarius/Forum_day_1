FactoryGirl.define do
  factory :post do
    title {Faker::Name.first_name}
    association :category
    comments { [create(:comment)] }
  end

  factory :post_without_comment do
    title "Teste"
    association :category
  end

end
