class Admin::PostsController < Admin::BaseController
  before_action :set_post, only: %i[edit update destroy]

  def index
    @posts = Post.recent_first
  end

  def edit; end

  def update
    @post.assign_attributes(post_params)
    @post.last_editor = logged_in_user
    @post.last_edited_at = Time.current

    if @post.save
      redirect_to admin_posts_path, notice: "Post updated successfully."
    else
      render_form_errors(@post, :edit)
    end
  end

  def destroy
    @post.destroy
    redirect_to admin_posts_path, notice: "Post deleted successfully."
  end

  private

  def set_post
    @post = Post.includes(:user).find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
