class ReviewsController < ApplicationController
  before_action :set_review, only: %i[ show edit update destroy ]
  before_action :set_product
  before_action :authenticate_user!

  # GET /reviews or /reviews.json
  def index
    @reviews = Review.all
  end

  # GET /reviews/1 or /reviews/1.json
  def show
    if @review.user_id == current_user.id
      render :show
    else
      redirect_to product_path(@product)
    end
  end

  # GET /reviews/new
  def new
    @review = Review.new
  end

  # GET /reviews/1/edit
  def edit
    if @review.user_id == current_user.id
      render :edit
    else
      redirect_to product_path(@product)
    end
  end

  # POST /reviews or /reviews.json
  def create
    @review=Review.create(review_params)
    @review.user_id=current_user.id
    @review.product_id=@product.id
    redirect_to @product if @review.save
  end

  # PATCH/PUT /reviews/1 or /reviews/1.json
  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to review_url(@review), notice: "Review was successfully updated." }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1 or /reviews/1.json
  def destroy
    @review.destroy!

    respond_to do |format|
      format.html { redirect_to reviews_url, notice: "Review was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end

    def set_product
      @product=Product.find(params[:product_id])
    end

    # Only allow a list of trusted parameters through.
    def review_params
      params.require(:review).permit(:star_rating, :subject, :content, :product_id, :user_id)
    end
end
