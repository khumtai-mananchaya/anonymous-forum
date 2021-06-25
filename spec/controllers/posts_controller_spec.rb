require 'rails_helper'

RSpec.describe PostsController, type: :controller do
    describe "index" do
        let(:fac_user) {FactoryBot.create(:user)}
        before do
            Current.user = fac_user
        end
        subject { get :index }
        it { is_expected.to be_successful }
        it { is_expected.to have_http_status "200" }
    end

    describe "POST #create" do
        let(:fac_user) {FactoryBot.create(:user)}
        let(:create_new){post :create, :params => { :post => { post_content: "Checking if I can add a post" }, :format => :json}}
        before do
            Current.user = fac_user
        end
        it { expect{create_new}.to change(Post, :count).by(1) }
    end

    describe "PUT #update" do
        let(:fac_user) {FactoryBot.create(:user)}
        let(:post) {Post.create(post_content: "Change me", username: fac_user.username)}
        let(:update_action) {put :update, params: { id: post.to_param, post: { post_content: 'I can edit'} }; post.reload}
        before do
            Current.user = fac_user
        end
        it "updates a post" do
            expect{update_action}.to change(post, :post_content).from("Change me").to("I can edit")
        end
    end

    describe "DELETE #destroy" do
        let(:fac_user) {FactoryBot.create(:user)}
        subject{ delete :destroy, params: { id: @post.id } }
        before do
            Current.user = fac_user
            @post = Post.create(post_content: "My first test", username: fac_user.username)
        end
        it { expect{subject}.to change(Post, :count).by(-1) }
    end

    context "as a different user" do
        let(:fac_user_one) {FactoryBot.create(:user)}
        let(:fac_user_two) {FactoryBot.create(:user)}
        let(:post) {Post.create(post_content: "Hello World", username: fac_user_one.username)}
        let!(:update_action) {put :update, params: { id: post.to_param, post: { post_content: 'Can I edit?'} }; post.reload}
        let(:delete_action){ delete :destroy, params: { id: post.id }; post.reload }
        before do
            Current.user = fac_user_one
            @post_diff = Post.create(post_content: "Doing some tests!")
        end
        it "does not update an unauthorized post" do
            Current.user = fac_user_two
            expect {update_action}.to_not change(post, :post_content)
        end
        it "does not delete an unauthorized post" do
            Current.user = fac_user_two
            expect{delete_action}.to change(Post, :count).by(0)
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