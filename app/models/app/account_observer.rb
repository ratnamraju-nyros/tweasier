module App
  class AccountObserver < ActiveRecord::Observer
    
    def after_update(account)
      # if account.location_changed?
      #   address = Tweasier::Geolocation::Base.locate(account.location["query"])
      #   
      #   return if address.nil?
      #   
      #   account.location = {
      #     :query => account.location["query"],
      #     :lat => address.coordinates[0],
      #     :long => address.coordinates[1],
      #     :address => address.full_address,
      #     :city => address.state
      #   }
      #   
      #   account.save!
      # end
    end
  end
end
