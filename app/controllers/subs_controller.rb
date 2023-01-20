class SubsController < ApplicationController
  before_action :require_logged_in, only: %i[new create edit update]

  def index
    @subs = Sub.all
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id

    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def new
    @sub = Sub.new
  end

  def edit
    @sub = current_user.subs.find_by(id: params[:id])
    render :edit
  end

  def show
    @sub = Sub.find_by(id: params[:id])
    if @sub
      render :show
    else
      redirect_to subs_url
    end
  end

  def update
    @sub = Sub.find_by(id: params[:id])

    if @sub.moderator_id == current_user.id && @sub.update(sub_params)
      redirect_to subs_url
    else
      flash[:errors] = ['Something went wrong!']
      render :edit
    end
  end

  private

  def sub_params
    params.require(:sub).permit(:title, :description)
  end
end
