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

    it "#edit return @post for edit" do
      get :edit, category_id: @category, id: @post
      expect(assigns(:post).title).to eq(@post.title)
    end
    
  end

  describe "create" do
    context "with valid parameters" do
      it "create post succeefully" do
        expect{
          post :create, category_id: @category,  post: FactoryGirl.attributes_for(:post, comments_attributes: [FactoryGirl.attributes_for(:comment)])
        }.to change(Post, :count).by(1)
      end

    it "after indlude redirect to #show" do
      post :create, category_id: @category, post: FactoryGirl.attributes_for(:post, comments_attributes:[FactoryGirl.attributes_for(:comment)])

      expect(response).to redirect_to category_post_path(@category, assigns(:post))
    end

    end

    context "with  invalid parametrs" do
      it "does not create a new post" do
        expect {
          post :create, category_id: @category, post: FactoryGirl.attributes_for(:post, title:nil, comments_attributes:[FactoryGirl.attributes_for(:comment)])
        }.to change(Post, :count).by(0)
      end

      it "redirect to #new" do
        post :create, category_id: @category,  post: FactoryGirl.attributes_for(:post, title:nil, comments_attributes: [FactoryGirl.attributes_for(:comment)])
        expect(response).to render_template(:new)
      end
    end
  end

  describe "update" do

  end

end
