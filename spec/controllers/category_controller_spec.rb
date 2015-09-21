require 'rails_helper'

RSpec.describe CategoryController, type: :controller do

  before :each do
    @category = FactoryGirl.create(:category)
  end
  
  describe "GET #posts" do

    it "returns http success" do
      get :posts, id: @category
      expect(response).to have_http_status(:success)
    end

    it "assign the requested to @category" do 
      get :posts, id: @category

      expect(assigns(:category)).to eq(@category)
    end
  end

  describe "GET #new" do
    it "assigns to a new Post to @post" do
      post = FactoryGirl.build(:post, category: @category)

      get :new, id: @category

      expect(assigns(:post).category).to eq(post.category)
    end
  end

end
