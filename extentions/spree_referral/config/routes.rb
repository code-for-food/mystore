Spree::Core::Engine.routes.draw do
  get 'r/:code' => 'referral#index', as: 'referral'
end
