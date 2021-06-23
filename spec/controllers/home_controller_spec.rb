require 'rails_helper'
require 'pry'

RSpec.describe HomeController, type: :controller do
    describe "index" do
        it "responds successfully" do
            get :index
            expect(response).to be_successful
        end
        it "returns a 200 response" do
            get :index
            expect(response).to have_http_status "200"
        end
    end

    describe "post can be liked and unliked" do
        let(:like_post) {Post.create(post_content: "Like me")}
        let(:like_action) {put :like, params: { id: like_post.id }; like_post.reload}
        let(:unlike_action) {put :unlike, params: { id: like_post.id }; like_post.reload}
        before do
            @current_user = FactoryBot.create(:user)
            Current.user = @current_user
            sign_in @current_user
        end
        it "likes post" do
            expect{like_action}.to change(like_post, :cached_votes_up).to(1)
        end
        it "unlikes post" do
            like_action
            expect{unlike_action}.to change(like_post, :cached_votes_up).to(0)
        end
    end

    describe "post can be disliked and undisliked" do
        let(:dislike_post) {Post.create(post_content: "Dislike me")}
        let(:dislike_action) {put :dislike, params: { id: dislike_post.id }; dislike_post.reload}
        let(:undislike_action) {put :undislike, params: { id: dislike_post.id }; dislike_post.reload}
        before do
            @current_user = FactoryBot.create(:user)
            Current.user = @current_user
            sign_in @current_user
        end
        it "dislikes post" do
            expect{dislike_action}.to change(dislike_post, :cached_votes_down).to(1)
        end
        it "undislikes post" do
            dislike_action
            expect{undislike_action}.to change(dislike_post, :cached_votes_down).to(0)
        end
    end
end
