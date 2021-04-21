module Spree::ApiCheckoutControllerDecorator

  def order_buy_url
    order = spree_current_order
    return head 200 unless order.payments.unprocessed_payments.last

    render json: { url: fetch_alipay_url(order) }
  end

  private #

  def fetch_alipay_url(order)
    alipay = order.payments.unprocessed_payments.last.try(:payment_method)
    return nil if alipay.nil?

    product_names = order.products.pluck(:name)
    options = {
      out_trade_no: order.number,
      notify_url: url_for(only_path: false, controller: 'alipay_status', action: 'alipay_notify'),
      return_url: url_for(only_path: false, controller: 'alipay_status', action: 'alipay_done'),
      body: product_names.join(',').truncate(500), # char 1000
      #:payment_type => 1,
      subject: product_names.join(',').truncate(128) # char 256
    }
    alipay.provider.url(order, options)
  end
end

Spree::Api::V2::Storefront::CheckoutController.prepend Spree::ApiCheckoutControllerDecorator
