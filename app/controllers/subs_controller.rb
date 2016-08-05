class SubsController < ApplicationController

  def index
    @subs = Sub.all
  end

  def show
    @sub = Sub.find_by_id(params[:id])
  end

  def new
    @sub = Sub.new
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
  end

  def update
    @sub = Sud.find_by_id(params[:id])
    if @sub.update(sub_params)

    end

  end

  def destroy

  end

  def sub_params
    params.require(:sub).permit(:title, :description, :user_id, :id)
  end




end
