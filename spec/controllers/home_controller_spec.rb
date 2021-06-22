require 'rails_helper'

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
        before do
            @current_user = FactoryBot.create(:user)
            Current.user = @current_user
            sign_in @current_user
        end
        it "likes post" do
            put :like, params: { id: like_post.id }
            like_post.reload
            expect(like_post.cached_votes_up).to eq(1)
        end
        it "unlikes post" do
            put :unlike, params: { id: like_post.id }
            like_post.reload
            expect(like_post.cached_votes_up).to eq(0)
        end
    end

    describe "post can be disliked and undisliked" do
        let(:dislike_post) {Post.create(post_content: "Dislike me")}
        before do
            @current_user = FactoryBot.create(:user)
            Current.user = @current_user
            sign_in @current_user
        end
        it "dislikes post" do
            put :dislike, params: { id: dislike_post.id }
            dislike_post.reload
            expect(dislike_post.cached_votes_down).to eq(1)
        end
        it "undislikes post" do
            put :undislike, params: { id: dislike_post.id }
            dislike_post.reload
            expect(dislike_post.cached_votes_down).to eq(0)
        end
    end
end
