class ConfirmationsController < Clearance::ConfirmationsController
  
  def url_after_create
    app_user_path
  end
  
end
