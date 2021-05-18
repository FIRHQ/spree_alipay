module Spree
  class Gateway::AlipayWap < Gateway::AlipayDirect
    def service
      ServiceEnum.alipay_wap
    end

    def cancel(_response)
      Rails.logger.info("cancel #{_response}....")
      Rails.logger.info("just logger, do nothing")
    end
  end
end
