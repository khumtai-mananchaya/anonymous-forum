class HomeController < ApplicationController
  def index
    @post_cont = Post.all.order('created_at DESC')
  end

  def date_since_update(post_date)
    diff_date = (post_date.to_date - DateTime.now.utc.to_date).to_i.abs
  end
  helper_method :date_since_update

  def time_since_update(post_time)
    diff_time = (Time.now.utc - post_time.to_time).to_i / 3600
  end
  helper_method :time_since_update


end
