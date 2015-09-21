require 'rails_helper'

RSpec.describe CategoryController, type: :controller do

  describe "GET #posts" do
    it "returns http success" do
      get :posts
      expect(response).to have_http_status(:success)
    end

    it "assign the requested to @category" do
      category = FactoryGirl.create(:category)
      
      get :posts, id: category

      expect(assigns(:category)).to eq(category)
    end
  end

end
