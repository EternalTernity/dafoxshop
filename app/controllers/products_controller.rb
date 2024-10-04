class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show edit update destroy ]

  def dafoxtech
  end

  #put pages on all products per 5
  def adopisoft
    @products = Product.all
    @categories=Category.all

    # Filter by category
    if params[:category].present?
      @cat=Category.find_by_name(params[:category])
      @products=@cat.products
    else
      @products = Product.all
    end

    # Filter by price
    if params[:price].present?
      selected_prices=params[:price].map(&:to_i)
      price_ranges={
        1 => 1000..3000,
        2 => 3001..5000,
        3 => 5001..7000,
        4 => 7001..9999
      }

      ranges=selected_prices.map { |price|price_ranges[price] }.compact
      @products=@products.where(price: ranges) unless ranges.empty?
    end
    # Filter by star
    if params[:star].present?
      @products=@products.select { |product| product.average_rating >= params[:star].to_i }
    end

    @products = @products.page(params[:page]).per(16)
  end
  
  def search
    if params[:search_title].present?
      @products=Product.where("name ILIKE ?", "%#{params[:search_title]}%")
    else
      @products=[]
    end

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update("search_results", partial: "products/search_results", locals: { products: @products })
      end
    end
  end
  # GET /products or /products.json
  def index
    @products=Product.all

  end

  # GET /products/1 or /products/1.json
  def show
    @product=Product.friendly.find(params[:id])
    @reviews=@product.reviews.page(params[:page]).per(5)
  end

  # GET /products/new
  def new
    @review=Review.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to product_url(@product), notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to product_url(@product), notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.friendly.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def product_params
    params.require(:product).permit(:name, :description, :price, :created_by_id)
  end
end
