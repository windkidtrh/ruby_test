class UsersController < ApplicationController

  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,   only: :destroy

  def show
    @user = User.find(params[:id])
    redirect_to root_url and return unless !@user.nil?
    #暂时不知道这里最后那个代码对不对
    # debugger
  end

  def new
    @user =User.new
  end

  def index
    # @users =User.paginate(page: params[:page])
    @users = User.where(activated: true).paginate(page: params[:page])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # log_in @user  #注册成功则会自动登录
      # UserMailer.account_activation(@user).deliver_now
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
      # flash[:success] = "Welcome to the Sample App!"
      # redirect_to user_url(@user)
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end


    private

      def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
      end

      # 前置过滤器

      # 确保用户已登录
      def logged_in_user
        unless logged_in?
          store_location
          flash[:danger] = "Please log in."
          redirect_to login_url
        end
      end

      # 确保是正确的用户
      def correct_user
        @user = User.find(params[:id])
        redirect_to(root_url) unless current_user?(@user)
      end

      # 确保是管理员
      def admin_user
        redirect_to(root_url) unless current_user.admin?
      end

end
