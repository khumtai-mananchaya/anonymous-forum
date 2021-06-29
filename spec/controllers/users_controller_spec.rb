require 'rails_helper'

RSpec.describe UsersController, type: :controller do

    let(:fac_user) {FactoryBot.create(:user)}

    describe "index" do
        subject { get :index }
        it { is_expected.to be_successful }
        it { is_expected.to have_http_status "200" }
    end

    describe 'GET #show' do
        before { get :show, params: { id: fac_user.id } }
        it { expect(response).to be_successful }
    end

    describe "POST #create" do
        let(:upload_avatar) {fixture_file_upload(Rails.root.join('spec','controllers','moneyforwardlogo.png'), 'image/png')}
        let(:fac_user_avatar) {FactoryBot.create(:user, avatar: upload_avatar)}

        it { expect{fac_user}.to change(User, :count).by(1) }
        it 'attaches the uploaded avatar' do
            expect {fac_user_avatar}.to change(ActiveStorage::Attachment, :count).by(1)
        end
    end
end