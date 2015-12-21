class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(created_at: :desc)
  end
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  def edit
   @user = User.find(params[:id])
    unless current_user == @user
    redirect_to root_path, notice: 'loginし直してください'
    end
  end
  def update
    @user = User.find(params[:id])
    unless current_user == @user
    redirect_to root_path, notice: 'loginし直してください'
    end
    if @user.update(user_params)
      redirect_to root_path , notice: '基本情報を編集しました'
    else
      render 'edit'
    end
  end
  def followings
    #@user = User.find(params[:id])
    @users = current_user.following_users#.find(params[:id]).followed
    render 'show_follow'
  end
  def followers
    #@user = User.find(params[:id])
    @users = current_user.follower_users#.find(params[:id]).followed
    render 'show_follower'
  end
  private
  def user_params
    params.require(:user).permit(:name,:email, :password, :age,:profile,:area,:gender,:password_confirmation)
  end
end