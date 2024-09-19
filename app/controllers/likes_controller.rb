class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @review=Review.find(params[:review_id])
    @like=@review.likes.new(user: current_user)
    redirect_to @review.product if @like.save
  end

  def destroy
    @like=Like.find(params[:id])
    @review=@like.review
    redirect_to @review if @like.destroy
  end
end
