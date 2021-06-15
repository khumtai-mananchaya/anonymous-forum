require 'rails_helper'

RSpec.describe PostsController, type: :controller do
    describe "index" do
        before do
            Current.user = FactoryBot.create(:user)
            #post :create, params: { post_content: "temp content", user: @user }
        end
        it "responds successfully" do
            get :index
            expect(response).to be_successful
        end
        it "returns a 200 response" do
            get :index
            expect(response).to have_http_status "200"
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
