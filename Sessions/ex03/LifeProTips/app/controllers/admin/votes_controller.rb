class Admin::VotesController < Admin::BaseController
  before_action :set_vote, only: :destroy

  def index
    @posts = Post.includes(votes: :user).joins(:votes).distinct.recent_first
  end

  def destroy
    @vote.destroy
    redirect_to admin_votes_path, notice: "Vote deleted successfully."
  end

  private

  def set_vote
    @vote = Vote.find(params[:id])
  end
end
