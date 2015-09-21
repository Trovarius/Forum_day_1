# spec/models/category.rb

require 'rails_helper'

RSpec.describe Category, type: :model do
 describe "#valid?" do
   
   context 'name' do
     
     it 'is not null' do
       category = FactoryGirl.build(:category, :name => nil)
       expect(category).to_not be_valid
     end

     it 'is too long (length: 100)' do
       category =  FactoryGirl.build(:category, :name => "a" * 101)

       expect(category).to_not be_valid
     end

   end

 end

 describe "name format" do
   context "name" do
    
     it "show amount of posts" do
      category = FactoryGirl.create(:category)
      post1 = FactoryGirl.build(:post, category:category, title:"teste")
      post2 = FactoryGirl.build(:post, category:category, title: "teste2")

      category.posts = [post1, post2]

      expect(category.posts.count).to equal(2)

     end

   end
 end
end
