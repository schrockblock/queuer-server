RailsApp::Application.routes.draw do
  mount SimpleAdmin::Engine => '/admin', :as => :simple_admin

  namespace :api, :defaults => { :format => 'json' } do
    namespace :v1 do
      resource :session, :only => [:create]
      resources :users do
      	resources :projects do
      	  resources :tasks
      	end
      end
    end
  end
end
