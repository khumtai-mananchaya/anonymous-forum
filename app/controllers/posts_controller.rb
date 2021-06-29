class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :only_authorized_user!, only: %i[ edit update destroy ]

  # GET /posts or /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1 or /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)
    session[:post_id] = @post.id
    #Get current user id and add it to Post database
    @post.username = Current.user.username
    @post.image.attach(post_params[:image]) if post_params[:image].present?

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: "Post created" }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params) && Current.user.username == @post.username
        @post.image.attach(post_params[:image]) if post_params[:image].present?
        format.html { redirect_to @post, notice: "Post updated" }
        format.json { render :show, status: :ok, location: @post }
      else
        logger.debug "Failed at else"
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
     @post.image.purge
     @post.destroy
     respond_to do |format|
     format.html { redirect_to root_path, notice: "Post deleted" }
     format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:post_content, :id, :username, :image)
    end
    def only_authorized_user!
        redirect_to root_path, alert: 'You are not the owner of the post' if Current.user.username != @post.username
    end
end