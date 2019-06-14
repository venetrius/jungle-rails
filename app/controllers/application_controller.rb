class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def cart
    @cart ||= cookies[:cart].present? ? JSON.parse(cookies[:cart]) : {}
  end
  helper_method :cart

  def enhanced_cart
    @enhanced_cart ||= Product.where(id: cart.keys).map {|product| { product:product, quantity: cart[product.id.to_s] } }
  end
  helper_method :enhanced_cart

  def cart_subtotal_cents
    enhanced_cart.map {|entry| entry[:product].price_cents * entry[:quantity]}.sum
  end
  helper_method :cart_subtotal_cents

  def order_products
    @order_products ||= @order.line_items.all.map {|item|  {product:item.product, quantity: item.quantity}} 
  end
  helper_method :order_products

  def product_ratings
    @product_ratings ||= @product.ratings.all
      .map{|rating| {rating:rating.rating, description: rating.description, user: rating.user.email, created_at: rating.created_at}} 
      .sort { |a, b| b[:created_at] <=> a[:created_at] }
  end
  helper_method :product_ratings

  def update_cart(new_cart)
    cookies[:cart] = {
      value: JSON.generate(new_cart),
      expires: 10.days.from_now
    }
    cookies[:cart]
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def authenticated
    redirect_to '/login' unless current_user
  end

  def http_authenticate
     authenticate_or_request_with_http_basic do |username, password|
        puts  Rails.configuration.admin[:user_name]
        puts  Rails.configuration.admin[:password]
        if username == Rails.configuration.admin[:user_name] && Rails.configuration.admin[:password]
          puts 'ok'
          return true
        end
    end
end

end
