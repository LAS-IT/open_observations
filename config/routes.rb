Prolearning::Application.routes.draw do

  resources :interactions do
    resources :snapshots, only: [:create, :destroy]
  end
  resources :observations do
    get :start, on: :member
    get :record, on: :member
    get :confident_in, on: :member
    post :summaries, on: :collection
    resources :interactions do
      get 'edit_block/:block' => 'interactions#edit_block', on: :collection, as: 'edit_block'
      get 'summarize/:from/:to' => 'interactions#summarize', on: :collection, as: 'summarize'
    end
  end

  resources :focuses
  resources :courses do
    resources :observations
  end
  resources :teachers
  resources :departments do
    resources :courses
  end
  resources :programs do
    resources :departments
  end
  resource :school
  resources :schools do
    resources :focuses
  end

  devise_for :users
  resources :users do
    post :add, on: :collection
  end

  get "dashboard/index", as: :dashboard_index
  get "dashboard/" => 'dashboard#index', as: :dashboard
  get "static/index"
  root to: 'static#index'

  # default route - to avoid errors
  get "*path" => 'static#index'
end
