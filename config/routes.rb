Rails.application.routes.draw do
	root to: redirect path: 'currencies'

	resources :currencies
end
