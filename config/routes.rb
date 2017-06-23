Rails.application.routes.draw do
  root "static_pages#show", page: "home"
  get "/signup", to: "users#new"
  get "static_pages/*page", to: "static_pages#show"
end
