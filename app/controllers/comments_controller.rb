class CommentsController < ApplicationController
    def create
        @product = Product.find_by(id: params[:product_id])
        @comment = @product.comments.create(comments_params)
        @comment.user_id = current_user.id
        if @comment.save
            redirect_to product_path(@product),notice: 'Comment Added'
        end
    end
    def destroy
        @product = Product.find_by(id: params[:product_id])
        @comment = @product.comments.find_by(id: params[:id])
        if @comment.destroy
            redirect_to product_path(@product),alert: 'Comment Deleted!'
        end
    end
    private
    def comments_params
        params.require(:comment).permit(:title)
    end
end