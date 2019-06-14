class RatingsController < ApplicationController

  def create
    product_id = params.require(:product_id)
    @product = Product.find(product_id)
    @rating = @product.ratings.create(rating_params)
    @rating.user = current_user
    if @rating.save
      redirect_to :back, notice: 'Review Added!'
    else
      render 'products/show'
    end

  end  

  private 

  def rating_params
    params.require(:rating).permit(:rating, :description)
  end
end
