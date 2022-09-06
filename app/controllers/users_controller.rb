class UsersController < ApplicationController
  include BCrypt

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @parties = @user.viewing_parties.all
  end

  def create
    if params[:user][:password] == params[:user][:confirm_password]
      user = User.new(user_params)
      if user.save
        redirect_to "/users/#{user.id}"
      else
        redirect_to "/register"
        flash[:alert] = "Error: #{error_message(user.errors)}"
      end
    else
      redirect_to "/register"
      flash[:alert] = "Your passwords did not match. Please try again."
    end 
  end

  def movie
    @user = User.find(params[:id])
    if params[:q] == "top rated"
      @top_movies = MovieDBFacade.top_movies
    elsif params[:q] != "top rated" && params[:q].present?
       @movies_matching_keyword = MovieDBFacade.searched_movies(params[:q])[0..39]
    end
  end


  def discover
    @user = User.find(params[:id])
  end

  def login_form
  end

  # def password
  #   @password ||= Password.new(password_digest)
  # end

  # def password=(new_password)
  #   @password = Password.create(new_password)
  #   self.password_digest = @password
  # end

  private 
  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end