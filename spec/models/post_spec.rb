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
        comment = create(:comment)
        post1 = FactoryGirl.create(:post, category: category, comments: [comment], title: 'a')

        expect(FactoryGirl.build(:post, category: category, title: 'a')).to_not be_valid

      end

    end

    context "comment" do
      it "has to have at least one" do
        post = FactoryGirl.build(:post)
        post.comments.build(FactoryGirl.attributes_for(:comment))

        expect(post).to be_valid
      end
    end
  end

  describe "create" do
    it "with nested comments" do

      expect{
        FactoryGirl.build(:post, comments_attributes:[FactoryGirl.attributes_for(:comment)])
      }.to change(Comment, :count).by(1)

    end
  end

  describe "update" do
    it "title" do
      post = FactoryGirl.create(:post)
      title = post.title
      
      post.update_attributes(title: "NewTitle")

      expect(post.title).to_not eq(title)
      
    end

    it "fails when title is nil" do
      post = FactoryGirl.create(:post)
      title = post.title
      post.update_attributes(title: nil)
      expect(post).to_not be_valid
    end

    it "just titles keeping comments the same" do
      post = create(:post)
      comments_count = post.comments.count
      description = post.comments.first.description
      post.update_attributes(FactoryGirl.attributes_for(:post))
      expect(post.comments.first.description).to eq(description)

      expect(post.comments.count).to eq(comments_count)
    end
  end
end
