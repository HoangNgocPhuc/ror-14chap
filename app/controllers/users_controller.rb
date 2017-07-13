class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :load_user, except: [:index, :new, :create]
  before_action :correct_user, only: [:edit, :update]
  before_action :verify_admin, only: :destroy

  def index
    @users = User.sort.paginate page: params[:page],
      per_page: Settings.user.per_page
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      @user.send_activation_email
      flash[:info] = t ".check_email"
      redirect_to root_url
    else
      flash.now[:danger] = t ".danger"
      render :new
    end
  end

  def show
    redirect_to root_url unless @user.activated
    @microposts = @user.microposts.sort_by_time.paginate page: params[:page],
      per_page: Settings.micropost.per_page
    @comment = Comment.new
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t ".update_success"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t ".delete_success"
    else
      flash[:warning] = t ".delete_lost"
    end
    redirect_to users_url
  end

  def following
    @title = t "users.following.title"
    @user  = User.find_by id: params[:id]
    @users = @user.following.paginate page: params[:page],
      per_page: Settings.user.per_page
    render :show_follow
  end

  def followers
    @title = t "users.followers.title"
    @user  = User.find_by id: params[:id]
    @users = @user.followers.paginate page: params[:page],
      per_page: Settings.user.per_page
    render :show_follow
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end

  def load_user
    @user = User.find_by id: params[:id]
    return @user if @user.present?
    render file: "public/404.html"
  end

  def logged_in_user
    return if logged_in?
    flash[:danger] = t ".pls_login"
    redirect_to login_url
  end

  def correct_user
    redirect_to root_url unless @user.current_user? current_user
  end

  def verify_admin
    redirect_to root_url unless current_user.admin?
  end
end
