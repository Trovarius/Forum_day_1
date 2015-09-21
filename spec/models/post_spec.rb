require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "#valid?" do
    context "title" do
    
      it "nil is not valid" do
        post = FactoryGirl.build(:post, title: nil)
        expect(post).to_not be_valid
      end

      it "is too long (length: 100)" do
        post = FactoryGirl.build(:post, title: "a"*101)
        expect(post).to_not be_valid
      end

      it "shoud be unique by category" do
        category = FactoryGirl.create(:category)
        post1 = FactoryGirl.create(:post, category: category, title: 'a')
        expect(FactoryGirl.build(:post, category: category, title: 'a')).to_not be_valid

      end

    end
  end
end
