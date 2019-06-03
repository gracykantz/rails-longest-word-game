Rails.application.routes.draw do
  get 'games_controller/new'
  post 'games_controller/score'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
