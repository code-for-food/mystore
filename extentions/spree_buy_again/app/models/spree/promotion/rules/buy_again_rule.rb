module Spree
	class Promotion
		module Rules
			class BuyAgainRule < Spree::PromotionRule
				attr_reader :user, :product_ids
				
				MATCH_POLICIES = %w(any all none)
        		preference :match_policy, :string, default: MATCH_POLICIES.first
				
				def applicable?(promotable)
					promotable.is_a?(Spree::Order)
				end

				def eligible?(order, options = {})
					@product_ids = Array.new
					@user = order.try(:user) || options[:user]
					
					# Don't apply for guest
					return true if !user
          			
          			current_order_product_ids = Array.new
          			
          			orders = user.orders.complete

          			order.line_items.each {|li| current_order_product_ids.push(li.variant.product_id)}
          			orders.each do |order|
          				
          				# only apply for shipped products
          				shipped_shipments = order.shipments.where(state: 'shipped')
          				
          				# move to next order to find the shipped shipments
          				next if shipped_shipments.empty?

          				shipped_shipments.each do |shipment|
          					
          					line_items = Array.new
          					
          					# ONLY apply for deliverd and not returned items
          					shipment.inventory_units.each do |u|

								line_items.push(u) if is_delivered_unit(u)

          					end
          					
          					# move to next line to find the shipped product
          					next if line_items.empty?
          					line_items.each do |item| 
          						product_ids.push(item.variant.product_id)
          					end

          				end
          			end

          			# return if the user didn't buy any product before
          			return true if product_ids.empty?
					
					if preferred_match_policy == 'all'
						unless product_ids.all {|p| current_order_product_ids.include?(p) }
							eligibility_errors.add(:base, eligibility_error_message(:missing_product))
						end

					elsif preferred_match_policy == 'any'
						unless current_order_product_ids.any? {|p| product_ids.include?(p) }
							eligibility_errors.add(:base, eligibility_error_message(:no_applicable_products))
						end
					else

						unless current_order_product_ids.none? {|p| product_ids.include?(p) }
							eligibility_errors.add(:base, eligibility_error_message(:has_excluded_product))
						end
					end
					
					eligibility_errors.empty?
				end

				def actionable?(line_item)
					case preferred_match_policy
						when 'any', 'all'
							product_ids.include? line_item.variant.product_id
						when 'none'
							product_ids.exclude? line_item.variant.product_id
						else
							raise "unexpected match policy: #{preferred_match_policy.inspect}"
					end
				end

				# Check if unit was really delivered and not return
				#  Depend to delivered days of shipping method
				def is_delivered_unit(u)
					
					# return DateTime.strptime(u.updated_at.to_s, "%Y-%m-%d %H:%M:%S").utc <= DateTime.now.utc - u.shipment.shipping_method.delivered_days && u.state != 'returned' && u.pending == false
					return u.updated_at.utc <= u.shipment.shipping_method.delivered_days.to_i.days.ago.utc && u.state != 'returned' && u.pending == false
				
				end

			end
		end
	end
end