class VotesController < ApplicationController
  before_action do
    require_account
  end

  def create
    post = Post.find(params[:post_id])
    value = params[:value].to_i

    Vote.cast_by!(user: logged_in_user, post:, value:)
    redirect_to post_path(post), notice: "Your vote has been recorded."
  rescue ActiveRecord::RecordInvalid => e
    redirect_to post_path(post), alert: e.record.errors.full_messages.to_sentence
  end
end
