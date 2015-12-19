class UsersController < ApplicationController
  def show
   @user = User.find(params[:id])
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
    if @user.update(user_params)
      redirect_to root_path , notice: '基本情報を編集しました'
    else
      render 'edit'
    end
  end
  private

  def user_params
    
    params.require(:user).permit(:name,:email, :password, :age,:profile,:area,:gender,:password_confirmation)
  end
end