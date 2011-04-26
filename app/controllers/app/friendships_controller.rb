module App
  class FriendshipsController < BaseController
    
    def create
      respond_to do |wants|
        wants.js do
          begin
            @account.client.friendship_create(params[:user])
            render :json => { :text => "You are now following #{params[:user]}" }
          rescue Twitter::General
            render :json => { :text => "You are already following #{params[:user]}" }
          end
        end
        wants.html do
          begin
            @account.client.friendship_create(params[:user])
            
            expire_user_cache_for(params[:user])
            
            flash[:notice] = "You are now following #{params[:user]}."
            redirect_back_or app_user_account_person_path(@account, :id => params[:user])
          rescue Twitter::General
            flash[:failure] = "An error occured, this if probably because you are already following #{params[:user]}."
            redirect_back_or app_user_account_person_path(@account, :id => params[:user])
          end
        end
      end
    end
    
    def destroy
      flash[:notice] = "You are no longer following #{params[:id]}, however they may take a few minutes to clear from our cache."
      user = @account.client.friendship_destroy(params[:id])
      # make sure we remember not to follow them again through auto follower.
      @account.ignored_people.build(:user => user).save!
      
      expire_user_cache_for(params[:id])
      
      redirect_back_or app_user_account_person_path(@account, :id => params[:id])
    rescue Twitter::General
      flash[:failure] = "An error occured, this if probably because you are not following #{params[:id]}."
      redirect_back_or app_user_account_person_path(@account, :id => params[:id])
    end
    
    protected
    def expire_user_cache_for(user)
      # TODO: make it so keys can be configured in one place.
      Tweasier::Cache::Base.expire!("#{@account.screen_name}_user_#{user.to_s}")
    end
    
  end
end
