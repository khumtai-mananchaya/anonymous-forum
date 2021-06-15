require 'rails_helper'

RSpec.describe PostsController, type: :controller do
    describe "index" do
        before do
            Current.user = FactoryBot.create(:user)
            @post = Post.create(post_content: "Doing some post controller test right now!")
            #post :create, params: { post_content: "temp content"}
        end
        it "responds successfully" do
            get :index
            expect(response).to be_successful
        end
        it "returns a 200 response" do
            get :index
            expect(response).to have_http_status "200"
        end
        it "adds a post" do
            expect {
                post :create, :params => { post_content: "Checking if I can add a post" }, :format => :json
                }.to change(Post, :count).by(1)
        end
        it "updates a post" do
            expect {
                patch :update, :params => {post_content: "I can edit", id: @post.id}
                @post.reload
              }.to change(@post, :post_content).to("I can edit")
        end
        it "deletes a post" do
            expect{
                delete :destroy, params: { id: @post.id }
            }.to change(Post, :count).by(-1)
        end
    end
    context "as a guest" do
        before do
            Current.user = nil
        end
        it "returns a 302 response" do
            get :index
            expect(response).to have_http_status "302"
        end
        it "redirects to sign_in page" do
            get :index
            expect(response).to redirect_to "/sign_in"
        end
    end
end
