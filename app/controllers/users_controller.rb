class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :followings, :followers, :likes]

  def index
    @users = User.order(id: :desc).page(params[:page]).per(25)
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(id: :desc).page(params[:page])
    counts(@user)
  end

  def new
    @user = User.new
    
    if params[:auth] == '1'
      @auth = 1
    else
      @auth = 0
    end
  end

  def create
    if params[:auth] == '1' 
      create_auth
    else
      
      @user = User.new(user_params)
  
      if @user.save
        flash[:success] = 'ユーザを登録しました。'
        redirect_to @user
      else
        flash.now[:danger] = 'ユーザの登録に失敗しました。'
        render :new
      end
    end
    
    def destroy
      unless current_user == User.find(params[:id])
        flash[:success] = '権限がありません。'
        redirect_to root_url
      else
        current_user.destroy
        flash[:success] = '退会完了。'
        redirect_to root_url
      end
    end
  end
  
  def create_auth
    return
  end

  #nav menues
  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page])
    counts(@user)
  end
  
  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page])
    counts(@user)
  end
  
  def likes
    @user = User.find(params[:id])
    @liked_microposts = @user.liked_microposts.page(params[:page])
    counts(@user)
  end



  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end