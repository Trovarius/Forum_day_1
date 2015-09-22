require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe '#valid' do
    context 'is valid' do
      it "with a post and a description" do
        comment = FactoryGirl.create(:comment)

        expect(comment).to be_valid
      end
    end

    context 'is invalid' do
      it "without a description" do
        comment = FactoryGirl.build(:comment, description:nil)
        expect(comment).to_not be_valid
      end

      it "with describition blank" do
        comment = FactoryGirl.build(:comment, description: '')
        expect(comment).to_not be_valid
      end

      it "without a related post" do
        comment = FactoryGirl.build(:comment, post: nil)
        expect(comment).to_not be_valid
      end
    end
  end
end
