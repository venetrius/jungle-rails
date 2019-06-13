class OrderReceipt < ApplicationMailer
  default from: 'notifications@example.com'
 
  def order_placed order
    @url  = 'http://example.com/login'
    @order = order
    @order_products = order.line_items.all.map {|item|  {product:item.product, quantity: item.quantity}}
    mail(to: @order.email, subject: 'Your order has been placed!')
  end
end
