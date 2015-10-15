class AddDeliveredDaysToSpreeShippingMethods < ActiveRecord::Migration
  def change
    add_column :spree_shipping_methods, :delivered_days, :integer
  end
end
