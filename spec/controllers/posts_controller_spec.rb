require 'rails_helper'

RSpec.describe PostsController, type: :controller do
    describe "index" do
        before do
            @current_user = FactoryBot.create(:user)
            Current.user = @current_user
        end
        subject { get :index }
        it { is_expected.to be_successful }
        it { is_expected.to have_http_status "200" }
    end

    describe "#new" do
        subject{post :create, :params => { :post => { post_content: "Checking if I can add a post" }, :format => :json}}
        before do
            @current_user = FactoryBot.create(:user)
            Current.user = @current_user
            sign_in @current_user
        end
        it { expect{subject}.to change(Post, :count).by(1) }
    end

    describe "#edit" do
        before do
            @current_user = FactoryBot.create(:user)
            Current.user = @current_user
            sign_in @current_user
        end
        it "updates a post" do
            random_post = Post.create(post_content: "Change me", username: @current_user.username)
            #subject {patch :update, :params => {post_content: "I can edit", id: random_post.id}}
            expect{patch :update, :params => {post_content: "I can edit", id: random_post.id};
            random_post.reload}.to change(random_post, :post_content).from("Change me").to("I can edit")
        end
    end

    describe "#delete" do
        subject{ delete :destroy, params: { id: @post.id } }
        before do
            @current_user = FactoryBot.create(:user)
            Current.user = @current_user
            @post = Post.create(post_content: "My first test", username: @current_user.username)
            sign_in @current_user
        end
        it { expect{subject}.to change(Post, :count).by(-1) }
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
