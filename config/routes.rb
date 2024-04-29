Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'documents/list', to: 'documents#list'
      post 'documents/create', to: 'documents#create'
    end
  end
end
