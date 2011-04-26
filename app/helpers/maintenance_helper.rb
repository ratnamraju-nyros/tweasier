module MaintenanceHelper
  
  # This helper allows us to broadcast a maintenance message
  # when present within the main layout.
  def maintenance_message
      return nil unless Configuration.maintenance
      Configuration.maintenance.message
  end
  
end
