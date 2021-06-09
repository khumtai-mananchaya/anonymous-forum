class HomeController < ApplicationController
  def index
    @post_cont = Post.all
  end
end
