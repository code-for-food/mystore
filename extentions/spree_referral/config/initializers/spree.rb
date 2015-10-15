Spree::PermittedAttributes.user_attributes.push :referral_code
Rails.application.config.spree.promotions.rules << Spree::Promotion::Rules::ReferralRule