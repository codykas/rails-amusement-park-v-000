class UsersController < ApplicationController
  before_action :authenticate_user, only: [:show]

  def home
  end

  def show
    @user = User.find_by(id: params[:id])
    @message = params[:message] if params[:message]
  end

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      set_session(user)
      redirect_to user_path(user)
    else
      render "new"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :height, :happiness, :nausea, :tickets, :password, :admin, :attraction_id, :id)
  end
end
