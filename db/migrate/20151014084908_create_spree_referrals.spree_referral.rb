# This migration comes from spree_referral (originally 20151014075001)
class CreateSpreeReferrals < ActiveRecord::Migration
  def change
    create_table :spree_referrals do |t|
    	t.string :code
    	t.integer :user_id
    end
  end
end
