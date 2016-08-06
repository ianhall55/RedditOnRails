class SubsController < ApplicationController

  def index
    @subs = Sub.all
  end

  def show
    @sub = Sub.find_by_id(params[:id])
    @posts = @sub.posts
  end

  def new
    @sub = Sub.new
    if logged_in?
      render :new
    else
      flash[:errors] = ["Must be logged in to create sub"]
      redirect_to subs_url
    end
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.user_id = current_user.id
    if @sub.save
      redirect_to sub_url(@sub.id)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def edit
    @sub = Sub.find_by_id(params[:id])
    if logged_in?
      render :edit
    else
      flash.now[:errors] = ["Must be logged in to edit sub"]
      render :show
    end
  end

  def update
    @sub = Sub.find_by_id(params[:id])
    if @sub.update(sub_params)
      redirect_to sub_url(params[:id])
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end

  end

  def destroy

  end


  before_action :user_is_moderator?, only: :edit

  private

  def user_is_moderator?
    @sub = Sub.find_by_id(params[:id])

    if current_user.id != @sub.user_id
      flash.now[:errors] = ["Must have created the sub to edit it"]
      render :show
    end
  end

  def sub_params
    params.require(:sub).permit(:title, :description, :user_id, :id)
  end

end
