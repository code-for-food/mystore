module Spree
	class ReferredRecords < Spree::Base
		belongs_to :referral
		belongs_to :user, class_name: Spree.user_class.to_s

		validates_presence_of :user
	end
end