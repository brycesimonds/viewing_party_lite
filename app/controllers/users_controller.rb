class UsersController < ApplicationController
  def new
  end

  def show
    user = User.find(params[:id])
  end

  def create
    user = User.new(name: params[:name], email: params[:email])
    if user.save
      redirect_to "/users/#{user.id}"
    else
      redirect_to "/register"
      flash[:alert] = "Error: #{error_message(user.errors)}"
    end 
  end

  def movie
    @user = User.find(params[:id])
    if params[:q] == "top rated"
      @top_movies = MovieDBFacade.top_movies
    end
  end
end