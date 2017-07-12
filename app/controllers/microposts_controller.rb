class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy

  def index
    @microposts = Micropost.sort_by_time.
      paginate page: params[:page],per_page: Settings.micropost.per_page
  end

  def create
    @micropost = current_user.microposts.build micropost_params

    if @micropost.save
      flash[:success] = t "microposts.create.create_success"
      redirect_to root_url
    else
      @feed_items = []
      render "static_pages/home"
    end
  end

  def destroy
    if @micropost.destroy
      flash[:success] = t "microposts.destroy.delete_success"
    else
      flash[:warning] = t "microposts.destroy.delete_fail"
    end
    redirect_to request.referrer || root_url
  end

  private

  def micropost_params
    params.require(:micropost).permit :title, :content, :picture
  end

  def correct_user
    @micropost = current_user.microposts.find_by id: params[:id]
    redirect_to root_url unless @micropost
  end
end
