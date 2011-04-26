ActionController::Routing::Routes.draw do |map|

  # App
  map.namespace :app do |app|
    app.resource :user do |user|
      user.resources :accounts, :collection => { :finalize => :get } do |account|
        account.resources :people
        account.resources :direct_messages
        account.resources :favourites
        account.resources :friendships
        account.resources :mentions
        account.resources :blacklists
        account.resources :statuses
        account.resources :retweets
        account.resources :spam_reports
        account.resources :searches, :member => { :clone => :post } do |search|
          search.resources :conditions, :controller => :search_conditions
          search.resources :results,    :controller => :search_results, :collection => { :follow => :post }
        end
        account.resources :search_batches
        account.resources :link_requests
        account.namespace :statistics do |stats|
          stats.resource  :home
          stats.resource  :account
          stats.resources :links
          stats.resources :searches
          stats.resources :followed_people
          stats.resources :unfollowed_people
        end
        account.resources :maps
      end
    end
    app.home "home", :controller => "users", :action => "show"
  end
  
  # Polls
  map.namespace :feedback do |feedback|
    feedback.resources :poll_entries
    feedback.resources :feedback_entries
  end
  
  # Static Routes
  map.with_options :controller => "pages", :action => "show" do |static|
    static.about    "/about",    :id => "about"
    static.faq      "/faq",      :id => "faq"
    static.features "/features", :id => "features"
    static.plans    "/plans",    :id => "plans"
    static.landing  "/landing",  :id => "landing"
  end

  # Misc
  map.resources :pages
  map.resource  :home
  
  # Clearance
  map.sign_in  "/sign_in",  :controller => "sessions", :action => "new"
  map.sign_out "/sign_out",  :controller => "sessions", :action => "destroy"
  map.sign_up "/sign_up", :controller => "users", :action => "new"
  map.resources :passwords, :controller => 'passwords', :only => [:new, :create]
  map.resource  :session,   :controller => 'sessions', :only => [:new, :create, :destroy]
  map.resources :users, :controller => 'users' do |users|
    users.resource :password, :controller => 'passwords', :only => [:create, :edit, :update]
    users.resource :confirmation, :controller => 'confirmations', :only => [:new, :create]
  end
  
  # Home mappings
  home_options = { :controller => "home", :action => "show" }
  map.home "/", home_options
  map.root      home_options
  
end