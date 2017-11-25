RailsApp::Application.routes.draw do
  mount SimpleAdmin::Engine => '/admin', :as => :simple_admin

  namespace :api, :defaults => { :format => 'json' } do
    namespace :v1 do
      resource :session, :only => [:create]
      resources :users
      resources :projects do
        resources :tasks
      end
      resources :sprints do
        resources :sprint_projects
        resources :days do
          resources :day_tasks
        end
      end
    end
  end
end
