Rails.application.routes.draw do

  resources :users, only: [:new, :create, :show] do
    member do
      resources :user_comments, only: [:new]
    end
  end
  resource :session, only: [:new, :create, :destroy]

  resources :goals, except: [:show] do
    member do
      resources :goal_comments, only: [:new]
    end
  end

  resources :goal_comments, except: [:new, :index, :show]
  resources :user_comments, except: [:new, :index, :show]


end
