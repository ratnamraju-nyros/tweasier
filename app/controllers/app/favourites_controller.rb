module App
  class FavouritesController < BaseController
    
    def index
      @favorites = @account.client.favorites(:page => params[:page])
    end
    
    def create
      flash[:notice] = "Tweet was favourited."
      @account.client.favorite_create(params[:id])
      redirect_back_or app_user_account_favourites_path(@account)
    end

    def destroy
      flash[:notice] = "Tweet was removed from favourites."
      @account.client.favorite_destroy(params[:id])
      redirect_back_or app_user_account_favourites_path(@account)
    end
    
  end
end
