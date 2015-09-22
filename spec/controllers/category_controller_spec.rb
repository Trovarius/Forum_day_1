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

    it "expect to render new template" do
       get :new, id: @category
       expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    context "valid parameters" do
      it "create a new post" do
        expect {
          post :create, id: @category,  post: {title: 'Teste', category: @category}
        }.to change{ @category.posts.count }.by(1)
      end

      it "redirect to post after success inclusion" do
        post :create, id: @category, post: FactoryGirl.attributes_for(:post)

        expect(response).to redirect_to post_path(assigns[:post])
      end

    end
  end

end
