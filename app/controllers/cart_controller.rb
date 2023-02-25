class CartController < ApplicationController
    before_action :authenticate_user!
    def show
      @render_cart = true
    end
  
    def add
      @product = Product.find_by(id: params[:id])
      quantity = params[:quantity].to_i
      current_orderable = @cart.orderables.find_by(product_id: @product.id)
      if current_orderable && quantity > 0
      elsif quantity <= 0
         current_orderable.destroy
      else
        @cart.orderables.create(product: @product, quantity:)
        redirect_to cart_path,notice: 'Added to cart'
      end
  
  
    end
  
    def destroy
      Orderable.find_by(id: params[:id]).destroy
      redirect_to products_path,alert: 'Removed From Cart!'
    end
  end
  