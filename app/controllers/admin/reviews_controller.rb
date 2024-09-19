class Admin::ReviewsController<AdminController
  before_action :authenticate_user!, only: [:is_published, :destroy]
  
  def index
    @reviews=Review.all
  end

  def is_published
    @review=Review.find_by(id: params[:id])
    if @review.update(is_published: true)
      redirect_to admin_reviews_path, notice: "Review published successfully."
    else
      redirect_to admin_reviews_path, notice: "Review cannot be published."
    end
  end

  def destroy
    @review=Review.find_by(id: params[:id])
    @review.destroy
    redirect_to admin_reviews_path
  end
end