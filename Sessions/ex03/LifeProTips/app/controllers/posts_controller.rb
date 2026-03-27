class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  before_action only: %i[new create edit update destroy] do
    require_account
  end
  before_action :authorize_post_edition, only: %i[edit update]
  before_action :authorize_post_destruction, only: :destroy

  def index
    @posts = Post.recent_first
  end

  def show
    return if signed_in?

    redirect_to root_path, notice: "You need an account to see this"
  end

  def new
    @post = Post.new
  end

  def create
    @post = logged_in_user.posts.build(post_params)

    if @post.save
      redirect_to post_path(@post), notice: "Post created successfully."
    else
      render_form_errors(@post, :new)
    end
  end

  def edit; end

  def update
    @post.assign_attributes(post_params)
    @post.last_editor = logged_in_user
    @post.last_edited_at = Time.current

    if @post.save
      redirect_to post_path(@post), notice: "Post updated successfully."
    else
      render_form_errors(@post, :edit)
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path, notice: "Post deleted successfully."
  end

  private

  def set_post
    @post = Post.includes(:user, :last_editor, votes: :user).find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end

  def authorize_post_edition
    return if can_edit_post?(@post)

    redirect_to root_path, alert: "You are not allowed to edit this post."
  end

  def authorize_post_destruction
    return if can_destroy_post?(@post)

    redirect_to root_path, alert: "You are not allowed to delete this post."
  end
end
