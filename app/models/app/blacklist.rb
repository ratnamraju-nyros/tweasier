class App::Blacklist < ActiveRecord::Base
	 belongs_to :account,  :class_name => "App::Account",         :foreign_key => :account_id
	
	validates_presence_of  :screen_name
end
