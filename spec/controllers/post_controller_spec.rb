require 'rails_helper'

RSpec.describe PostController, type: :controller do

  before(:each) do
    @category = FactoryGirl.create(:category)
    @post = FactoryGirl.create(:post, category: @category)
  end

  describe "GET" do
    it "#index then returns a @category" do
      get :index , category_id: @category

      expect(assigns(:category)).to eq(@category)
    end
    
    it "#new the return @category with post" do
      get :new, category_id: @category
      expect(assigns(:category).posts).to_not be_nil
    end

    it "#show return @post" do
      get :show, category_id: @category, id: @post
      expect(assigns(:post).count).to eq(1)
    end
    
  end

  describe "create" do
    context "with valid parameters" do
      it {
        expect{
          post :create, category_id: @category,  post: FactoryGirl.attributes_for(:post, comments_attributes: [FactoryGirl.attributes_for(:comment)])
        }.to change(Post, :count).by(1)
      }
    end
  end

end
