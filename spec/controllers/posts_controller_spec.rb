require 'rails_helper'

RSpec.describe PostsController, type: :controller do
    describe "index" do
        before do
            Current.user = FactoryBot.create(:user)
            #@post = Post.create(post_content: "Doing some post controller test right now!")
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
            post = Post.create(post_content: "Checking if I can add a post")
            expect(Post.count).to eql(1)
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
