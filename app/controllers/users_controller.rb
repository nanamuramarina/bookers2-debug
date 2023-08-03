class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update]
  def new
    @user = User.new
  end



  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def index
    @users = User.all
    @book = Book.new
  end

  def edit
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user)
    end
    @user = current_user
  end
  
  def update
    user_id = params[:id]
    login_user_id = current_user.id
   if(user_id.to_i != login_user_id)
     redirect_to user_path
   end
    @user = User.find(current_user.id)
   if @user.update(user_params)
     flash[:notice] = "successfully"
     redirect_to user_path(current_user.id)
   else
    flash[:notice]="error"
    render :edit
   end
  end

  def destroy
  end
  
  def follows
    user = User.find(params[:id])
    @users = user.following_users
  end
  
  def followers
    user = User.find(params[:id])
    @user = user.follower_users
  end


  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
