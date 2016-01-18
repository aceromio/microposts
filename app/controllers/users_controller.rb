class UsersController < ApplicationController
  def index
    @user = User.find(params[:id])
    @microposts = @user.microposts.page(params[:page]).per(1)
    @users = User.page(params[:page]).per(1).order(:id)
  end
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(created_at: :desc).page(params[:page]).per(3)
    #@microposts_page = @microposts
  end
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
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
    @followings_pages = @users.page(params[:page]).per(2)
    render 'show_follow'
  end
  def followers
    #@user = User.find(params[:id])
    @users = current_user.follower_users#.find(params[:id]).followed
    @follower_pages = @users.page(params[:page]).per(2)
    render 'show_follower'
  end
  
  private
  def user_params
    params.require(:user).permit(:name,:email, :password, :age,:profile,:area,:gender,:password_confirmation,:image, :image_cache, :remove_image)
  end
end