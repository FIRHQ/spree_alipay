module Spree
  class Gateway::AlipayDirect < Gateway::AlipayDualfun
    def service
      ServiceEnum.create_direct_pay_by_user
    end

    def auto_capture?
      return true
    end

    def cancel(_response)
      Rails.logger.info("cancel #{_response}....")
      Rails.logger.info("just logger, do nothing")
    end
  end
end
