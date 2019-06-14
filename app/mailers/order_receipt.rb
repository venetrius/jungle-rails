class OrderReceipt < ApplicationMailer
  default from: 'notifications@example.com'
 
  def order_placed order
    @url  = 'no-reply@jungle.com'
    @order = order
    @order_products = order.line_items.all.map {|item|  {product:item.product, quantity: item.quantity}}
    mail(to: @order.email, subject: "Order no.#{order.id} has been placed! ")
  end
end
