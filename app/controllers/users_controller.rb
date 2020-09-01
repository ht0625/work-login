class UsersController < ApplicationController
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
      # redirect_to user_path(@user.id)
      session[:user_id] = @user.id
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end
  def show
    @user = User.find(params[:id])
    @favorites = current_user.favorite_blogs
    #@login_user_blogs = current_user.blogs
    @favorited_total_counts = Favorite.joins(:blog).where(blogs: {user_id: current_user.id}).count
  end
  private
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end
