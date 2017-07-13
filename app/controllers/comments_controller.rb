class CommentsController < ApplicationController
  before_action :logged_in_user, except: :show
  before_action :load_comment, :correct_user, only: [:edit, :update, :destroy]

  def create
    @micropost = Micropost.find_by id: params[:micropost_id]
    @comment = @micropost.comments.new comment_params
    @comment.user_id = current_user.id
    if @comment.save
      respond_to do |format|
        format.html {redirect_to :back}
        format.js
      end
    else
      flash[:danger] = t ".danger"
      redirect_to root_url
    end
  end

  def edit
    render file: "public/404.html" unless @comment.present?
    respond_to do |format|
      format.html {redirect_to :back}
      format.js
    end
  end

  def update
    if @comment.update_attributes comment_params
      respond_to do |format|
        format.html {redirect_to :back}
        format.js
      end
    else
      flash[:warning] = t ".update_lost"
      redirect_to root_url
    end
  end

  def destroy
    @id_comment_delete = params[:id]
    if @comment.destroy
      respond_to do |format|
        format.html {redirect_to :back}
        format.js
      end
    else
      flash[:warning] = t "delete_lost"
      redirect_to root_url
    end
  end

  private

  def correct_user
    redirect_to root_url if !@comment.user.current_user? current_user
  end

  def load_comment
    @comment = Comment.find_by id: params[:id]
  end

  def comment_params
    params.require(:comment).permit :content
  end
end
