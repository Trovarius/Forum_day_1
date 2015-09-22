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
    context "with valid parameters" do
      it "create a new post" do
        expect {
          post :create, id: @category,  post: {title: 'Teste'}
        }.to change{ @category.posts.count }.by(1)
      end

      it "redirect to the new post after success inclusion" do
        post :create, id: @category, post: FactoryGirl.attributes_for(:post)

        expect(response).to redirect_to post_path(@category, assigns[:post])
      end
    end

    context "with invalid parameters" do
      it "does not save the new post" do
        expect {
          post :create, id: @category, post: {title: nil}
        }.to_not change { @category.posts.count }
      end

      it "render new template" do
        post :create, id: @category, post: {title: nil}

        expect(response).to render_template :new
      end
    end
  end

  describe "PUT #update" do
    before :each do
      @post = FactoryGirl.create(:post, category: @category)
    end

    context "with valid parameters" do
      it "update a new post" do
        put :update, id:@category, post_id: @post, post: FactoryGirl.attributes_for(:post)
        expect(assigns(:post)).to eq(@post)
      end

      it "changes the post attributes" do
        put :update, id: @category, post_id: @post, post: FactoryGirl.attributes_for(:post, title: 'ChangeTitle')
        @post.reload

        expect(@post.title).to eq('ChangeTitle')
      end

      it "should redirect to post" do
        put :update, id: @category, post_id: @post, post: FactoryGirl.attributes_for(:post)

        expect(response).to redirect_to post_path(@category, @post)
      end
    end

    context "with invalid parameters" do
      it "locate post to change" do
        put :update, id: @category, post_id: @post, post: FactoryGirl.attributes_for(:post)
        expect(assigns(:post)).to eq(@post)
      end

      it "does not change @post attributes" do
        put :update, id:@category, post_id: @post, post: FactoryGirl.attributes_for(:post, title: nil)
        expect(@post.title).to_not eq(nil)
      end

      it "should redirect to edit temaple" do
        put :update, id:@category, post_id: @post, post: FactoryGirl.attributes_for(:post, title: nil)
        
        expect(response).to render_template :edit
      end
    end
  end

end
