module App
  class UsersController < BaseController
    
    def show
    end
    
    def edit
    end
    
    def update
      if @user.update_attributes(params[:user])
        flash[:success] = "Your account was successfully updated."
        redirect_to app_user_path
      else
        flash[:error] = "There was a problem updating your account, please try again."
        render :action => "edit"
      end
    end
    
    def destroy
      # TODO: add in cancel subscription logic here!
      @user.destroy
      
      flash[:success] = "Your account has been deleted. Sorry to see you leave!"
      redirect_to home_path
    end
    
  end
end
