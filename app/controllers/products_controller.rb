class ProductsController < ApplicationController
  protect_from_forgery except: [:ship] #http://stackoverflow.com/questions/1177863/how-do-i-ignore-the-authenticity-token-for-specific-actions-in-rails
  before_action :require_login, only: [:index, :show, :new, :edit, :create, :update, :destroy]
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def set_product_api(key, sku)
    if key and sku
      if current_user = User.find_by_key(key.downcase)
        if product = current_user.products.find_by_sku(sku.downcase)
          return product
        else
          # Not Found
          payload = {
            status: 404,
            message: "Not Found"
          }
          render json: payload, status: 404
          return
        end
      else
        # Unauthorized
        payload = {
          status: 401,
          message: "Unauthorized"
        }
        render json: payload, status: 401
        return
      end
    else
      # Bad Request
      payload = {
        status: 400,
        message: "Bad Request"
      }
      render json: payload, status: 400
      return
    end
  end

  def show_count
    if product = set_product_api(params[:key], params[:sku])
      payload = {
        status: 200,
        message: "OK",
        product: product
      }
      render json: payload, status: 200
    end
  end

  def ship
    if product = set_product_api(params[:key], params[:sku])
      if product.on_hand > 0
        product.on_hand -= 1
        product.save
        payload = {
          status: 200,
          message: "OK",
          product: product
        }
        render json: payload, status: 200
      else
        #out of stock
        payload = {
          status: 403,
          message: "Out of Stock",
          product: product
        }
        render json: payload, status: 403
      end
    end
  end

  # GET /products
  # GET /products.json
  def index
    @products = current_user.products
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
    respond_to do |format|
      format.js
    end
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)
    @product.user_id = current_user.id
    @product.save

    respond_to do |format|
      if @product.save
        format.html { redirect_to products_path, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    if @product.can_change?(current_user)
      respond_to do |format|
        if @product.update(product_params)
          format.js
          format.html { redirect_to @product, notice: 'Product was successfully updated.' }
          format.json { render :show, status: :ok, location: @product }
        else
          format.html { render :edit }
          format.json { render json: @product.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to products_path, "I'm sorry Dave, I'm afraid I can't do that."
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    if @product.can_change?(current_user)
      @product.destroy
      respond_to do |format|
        format.js
        format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      redirect_to products_path, "I'm sorry Dave, I'm afraid I can't do that."
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = current_user.products.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:sku, :on_hand)
    end
end
