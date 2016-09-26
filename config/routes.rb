Rails.application.routes.draw do
  resources :kintais
  resources :shains
  resources :holidays
  get "/kintais/:dd/new" => "kintais#new", as: :new_kintai_by_dd
end
