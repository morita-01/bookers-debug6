class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    #@users = User.all
    #@user_book = @Users.find(params[:id])
    @user = User.find(params[:id])
    @book = Book.new
  end

  def index
    @users = User.all
    @user = current_user
    @book = Book.new
  end


  def edit
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to user_path(current_user)
    end
  end

  def update
    user = User.find(params[:id])
    if user.update(user_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to user_path(user)#,notice: "You have updated user successfully."
    else
      @user = user
      render :edit
    end
  end

  def follows
    user = User.find(params[:id])
    @users = user.following_user.page(params[:page]).per(3).reverse_order
  end

  def followers
    user = User.find(params[:id])
    @users = user.follower_user.page(params[:page]).per(3).reverse_order
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
