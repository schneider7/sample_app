Rails.application.routes.draw do
  get 'sessions/new'
  get 'users/new'
  root 'static_pages#home'  
  get    '/help',      to: 'pages#help'
  get    '/about',     to: 'static_pages#about'
  get    '/contact',   to: 'static_pages#contact'
  get    '/signup',    to: 'users#new'
  get    '/login',     to: 'sessions#new'
  post   'login',      to: 'sessions#create'
  delete '/logout',    to: 'sessions#destroy'
  resources :users

  mount GitHooks::Engine, at: "/git_hooks"
  # mount GithubWebhooks::Engine, at: "/github_webhooks"
  # mount CardShark::Engine, at: "/cardshark"
end
