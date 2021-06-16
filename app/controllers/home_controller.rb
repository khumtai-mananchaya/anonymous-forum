class HomeController < ApplicationController
before_action :authenticate_user!, only: [:like, :unlike]

  def index
    @post_cont = Post.all.order('updated_at DESC')
  end

  def like
    @post = Post.find_by(params[:id])
    if Current.user.voted_for? @post
       @post.unliked_by Current.user
    else
       @post.liked_by Current.user
    end
  end

  def unlike
    @post = Post.find_by(params[:id])
    @post.unliked_by Current.user
  end

  def date_since_update(post_date)
    diff_date = (DateTime.now.utc.to_date - post_date.to_date).to_i.abs
  end
  helper_method :date_since_update

  def time_since_update(post_time)
    diff_time = (((Time.now.utc - post_time.to_time) / 3600) % 24).to_i.abs
  end
  helper_method :time_since_update

end
