require 'rails_helper'

RSpec.describe PostsController, type: :controller do
    describe "index" do
        before do
            @current_user = FactoryBot.create(:user)
            Current.user = @current_user
            @post = Post.create(post_content: "My first test", username: @current_user.username)
        end
        it "responds successfully" do
            get :index
            expect(response).to be_successful
        end
        it "returns a 200 response" do
            get :index
            expect(response).to have_http_status "200"
        end
        it "creates a post" do
            sign_in @current_user
            expect {
                post :create, :params => { :post => { post_content: "Checking if I can add a post" }, :format => :json}
                }.to change(Post, :count).by(1)
        end
        it "updates a post" do
            sign_in @current_user
            random_post = Post.create(post_content: "Doing some post controller test right now!", username: @current_user.username)
            expect {
                patch :update, :params => {post_content: "I can edit", id: random_post.id}
                random_post.reload
              }.to change(random_post, :post_content).to("I can edit")
        end
        it "deletes a post" do
            sign_in @current_user
            expect{
                delete :destroy, params: { id: @post.id }
            }.to change(Post, :count).by(-1)
        end
    end
    context "as a different user" do
        before do
            @user_one = FactoryBot.create(:user)
            @user_two = FactoryBot.create(:user)
            Current.user = @user_one
            @post_diff = Post.create(post_content: "Doing some tests!")
        end
        it "does not update an unauthorized post" do
            sign_in @user_two
            expect {
                patch :update, :params => {post_content: "I can edit", id: @post_diff.id}
                @post_diff.reload
            }.to_not change(@post_diff, :post_content)
        end
        it "does not delete an unauthorized post" do
            sign_in @user_two
                expect{
                delete :destroy, params: { id: @post_diff.id }
            }.to change(Post, :count).by(0)
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
