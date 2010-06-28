ActionController::Routing::Routes.draw do |map|
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"
  map.root :controller => "data", :action => 'index'

  map.connect 'expired/employee', :controller => 'resources', :action => 'custom', :id => 'employee_expired_query'
  map.connect 'expired/group', :controller => 'resources', :action => 'custom', :id => 'group_expired_query'

  map.connect 'report/ages', :controller => 'resources', :action => 'custom', :id => 'ages_query'

  map.connect ':controller/custom', :action => 'custom'

  map.connect 'q/:name', :controller => 'query', :action => 'custom'
  map.connect 'r/:name', :controller => 'query', :action => 'results'

  map.connect 'employees/search', :controller => 'employees', :action => 'search'

  map.connect 'employees/asset', :controller => 'employees', :action => 'custom', :id => 'asset_query'

  map.connect 'query/display', :controller => 'query', :action => 'display'
  map.connect 'query/employees', :controller => 'query', :action => 'find_employees'
  map.connect 'query/employees/:name', :controller => 'query', :action => 'find_employees'

  # Query all employee changes
  # query
  map.connect 'jobs/changes', :controller => 'jobs', :action => 'custom', :id => 'job_changes_query'
  # result
  map.connect 'jobs/query_changes/:id', :controller => 'jobs', :action => 'query_changes'

  map.connect 'query/:action', :controller => 'query'
  map.connect 'jobs/:action', :controller => 'jobs'
  map.connect 'groups/full', :controller => 'groups', :action => 'full'
 
  map.resources :employees
  map.resources :resources
  map.resources :groups
  map.resources :unit_companies
  map.resources :unit_branches
  map.resources :unit_groups
  map.resources :unit_teams
  map.resources :jobs
  map.resources :users
#  map.resources :site_contracts


  map.resources :employee_cloths
  map.resources :employee_records
  map.resources :employee_funds

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
