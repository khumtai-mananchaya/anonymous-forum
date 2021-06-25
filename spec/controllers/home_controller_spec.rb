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

    before do
        @current_user = FactoryBot.create(:user)
        Current.user = @current_user
    end
    let(:post) {Post.create(post_content: "Hello World")}
    describe "PUT #like" do
        subject { put :like, params: { id: post.id }}
        it "increments votes_up by 1" do
            expect{ subject }.to change{ Post.find(post.id).cached_votes_up }.to(1)
        end
    end
    describe "PUT #unlike" do
        subject { put :unlike, params: { id: post.id }}
         before do
             put :like, params: { id: post.id }
         end
        it "decrements votes_up by 1" do
            expect{subject}.to change{ Post.find(post.id).cached_votes_up }.to(0)
        end
    end
    describe "PUT #dislike" do
        subject { put :dislike, params: { id: post.id }}
        it "increments votes_down by 1" do
            expect{ subject }.to change{ Post.find(post.id).cached_votes_down }.to(1)
        end
    end
    describe "PUT #unlike" do
        subject { put :undislike, params: { id: post.id }}
         before do
             put :dislike, params: { id: post.id }
         end
        it "decrements votes_down by 1" do
            expect{subject}.to change{ Post.find(post.id).cached_votes_down }.to(0)
        end
    end
end