require 'rails_helper'

RSpec.describe Post, type: :model do
    before(:all) do
        @user = User.new(
            username: "TestingFoo",
            email:      "tester@example.com",
            password:   "randompasswordhere",
        )
        @post = Post.create(post_content: "Doing some crud test right now!")
    end

    it 'checks that a post can be created' do
        expect(@post).to be_valid
    end

    it "is invalid without a post_content" do
        post_invalid = Post.create(post_content: nil)
        post_invalid.valid?
    end

    it 'checks that a post can be read' do
        find_post = Post.find_by(post_content: "Doing some crud test right now!")
        expect(find_post.post_content).to eq(@post.post_content)
    end

    it 'checks that a post can be updated' do
        @post.update(post_content: "Doing some crud test right now! - edited")
        find_post = Post.find_by(post_content: "Doing some crud test right now! - edited")
        expect(find_post.post_content).to eq(@post.post_content)
    end

    it 'checks that a post can be destroyed' do
        @post.destroy
        expect(Post.count).to eql(0)
    end
end
