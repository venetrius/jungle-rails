module ProductHelper

  def sold_out?(product)
    product.quantity == 0
  end

  def average_rating(product)
    rating_values = product.ratings.all.map{|rating| rating.rating}
    rating_values.inject{ |sum, el| sum + el } / rating_values.size
  end 
  
end