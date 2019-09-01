class BidsController < ApplicationController

  def create
    product = Product.find(params[:product_id])
    value = params[:bid_value]
    @bid = Bid.new(product: product, user: current_user, value: value)
    @bid.save

    broadcast(product)
  end

  private

  def broadcast(product)
    productPrice = view_context.number_to_currency(product.final_price)
    bidHTML = ApplicationController.renderer.render(partial: 'bids/bid', locals: { bid: @bid })
    ProductChannel.broadcast_to product, productPrice: productPrice, bidHTML: bidHTML
  end
end
