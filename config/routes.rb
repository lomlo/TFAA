Rails.application.routes.draw do

  devise_for :users, :controllers => { registrations: 'registrations' }

  root to: "adventures#index"

  resources :adventures do
    resources :chapters
    get "game_destroy" => "games#delete"
  end

end
