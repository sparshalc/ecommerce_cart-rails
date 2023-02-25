class ProductsController < ApplicationController
    before_action :set_product,only: [:edit,:update,:view,:destroy, :show]
    before_action :authenticate_user!,only: [:edit,:update,:destroy, :show]
    before_action :correct_user,only: [:edit,:update,:destroy]
    before_action :set_search
    def index
        @product = Product.all
        @q = Product.ransack(params[:q])
        @product = @q.result(distinct: true)
    end
    def new
        @product = Product.new
    end
    def create
        @product = Product.create(product_params)
        if @product.save
            redirect_to product_path(@product),notice: 'Product added successfully'
        end
    end
    def show
        @comment = @product.comments.order('Created_at DESC')
    end
    def edit
    end
    def update
        if @product.update(product_params)
            redirect_to product_path(@product),notice: 'Product Updated!'
        end
    end
    def destroy
        if @product.destroy
            redirect_to products_path,alert: 'Product Deleted!'
        end
    end

    private
    def correct_user
        @product = current_user.products.find_by(id: params[:id])
        redirect_to products_path,alert: 'Not Authorized!' if @product.nil?
    end
    def product_params
        params.require(:product).permit(:name, :image, :user_id, :price, :image)
    end
    def set_product
        @product = Product.find_by(id: params[:id])
    end
end
