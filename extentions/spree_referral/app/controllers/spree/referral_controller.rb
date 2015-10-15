module Spree
	class ReferralController < Spree::StoreController
		def index
			session[:referral] = params[:code]
			redirect_to root_path
		end

	end
end