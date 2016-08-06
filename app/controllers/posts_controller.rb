

class PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find_by_id(params[:id])
    @subs = @post.subs
  end

  def new
    @post = Post.new
    @subs = Sub.all
    if logged_in?
      render :new
    else
      flash[:errors] = ["Must be logged in to create post"]
      redirect_to new_session_url
    end
  end

  def create

    @post = Post.new(post_params)
    @post.author_id = current_user.id
    if @post.save
      redirect_to subs_url
      # redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit
    @post = Post.find_by_id(params[:id])
    @subs = Sub.all
    if logged_in?
      render :edit
    else
      flash.now[:errors] = ["Must be logged in to edit post"]
      render :show
    end
  end

  def update
    @post = Post.find_by_id(params[:id])
    if @post.update(post_params)
      redirect_to post_url(params[:id])
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end

  end

  def destroy

  end

  before_action :user_is_author?, only: :edit

  def user_is_author?
    @post = Post.find_by_id(params[:id])

    if current_user.id != @post.author_id
      flash.now[:errors] = ["Must have created the post to edit it"]
      render :show
    end
  end

  def post_params
    params.require(:post).permit(:title, :url, :id, :content, :author_id, sub_ids: [])
  end



end
