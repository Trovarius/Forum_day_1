FactoryGirl.define do
  factory :post do
    title "MyString"
    association :category
    comments { [create(:comment)] }
  end

  factory :post_without_comment do
    title "Teste"
    association :category
  end

end
