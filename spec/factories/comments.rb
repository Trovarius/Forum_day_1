FactoryGirl.define do
  factory :comment do
    description "MyString"
    post Post.create(title: 'post')
  end

end
