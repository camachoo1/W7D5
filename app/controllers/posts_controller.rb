class PostsController < ApplicationController
  before_action :require_logged_in, only: %i[new create edit update]
  before_action :set_post, only: %i[edit update show]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id

    if @post.save
      redirect_to post_url(@post)
    else
      flash[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit
  end

  def update
    if @post.author_id == current_user.id && @post.update(post_params)
      redirect_to posts_url
    else
      flash[:errors] = ['Something went wrong!']
      render :edit
    end
  end

  def show
    if @post
      render :show
    else
      redirect_to subs_url
    end
  end

  private

  def set_post
    @post = Post.find_by(id: params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :url, :content)
  end
end
