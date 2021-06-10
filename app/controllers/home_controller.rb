class HomeController < ApplicationController
  def index
    @post_cont = Post.all
  end

  def date_since_update(post_date)
     diff_date = (post_date.to_date - DateTime.now.utc.to_date).to_i
  end
  helper_method :date_since_update


end
