# This migration comes from spree_buy_again (originally 20151011031540)
class AddDeliveredDaysToSpreeShippingMethods < ActiveRecord::Migration
  def change
    add_column :spree_shipping_methods, :delivered_days, :integer
  end
end
