class AttractionsController < ApplicationController
  before_action :authenticate_user, only: [:index, :new, :show]

  def index
    if logged_in?
      @attractions = Attraction.all
      @user = User.find_by(session[:user_id])
    else
      redirect_to root_path
    end
  end

  def new
    if current_user.admin?
      @attraction = Attraction.new
    else
      redirect_to root_path
    end
  end

  def create
    attraction = Attraction.new(attraction_params)
    if attraction.save
      redirect_to attraction_path(attraction)
    else
      render "new"
    end
  end

  def show
    @attraction = Attraction.find_by(id: params[:id])
    @user = User.find_by(id: current_user.id)
  end

  def edit
    if current_user.admin
      @attraction = Attraction.find_by(params[:id])
    else
      redirect_to attraction_path(Attraction.find_by(params[:id]))
    end
  end

  def update
    attraction = Attraction.find_by(params[:id])
    attraction.update(attraction_params)
    redirect_to attraction_path(attraction)
  end

  private

  def attraction_params
    params.require(:attraction).permit(:name, :tickets, :nausea_rating, :happiness_rating, :min_height)
  end
end
