module Spree
	Spree.user_class.class_eval do
		has_one :referral
		has_one :referred_record

		attr_accessor :referral_code

		after_create :create_referral
		after_create :referral_check

		def referred_by
			referred_record.try(:referral).try(:user)
		end

		def referred_count
			referral.referred_records.count
		end

		def referred?
			!referred_record.try(:referral).try(:user).nil?
		end

		private
			def referral_check

				puts self, "CODE222" 
				if !self.referral_code.nil?
					referred = Referral.find_by(code: referral_code)
				end
				
				if referred
					referred.referred_records.create(user: self)
				end
			end
	end
end