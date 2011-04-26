module App
  class AccountsController < BaseController
    before_filter :get_account, :only => [ :show, :edit, :update, :destroy ]

    def new
    end

    def create
      oauth.set_callback_url(finalize_app_user_accounts_url)

      session['request_token']  = oauth.request_token.token
      session['request_secret'] = oauth.request_token.secret

      redirect_to "http://#{oauth.request_token.authorize_url}"
    end

    def finalize
      oauth.authorize_from_request(session['request_token'],
                                   session['request_secret'],
                                   params[:oauth_verifier])

      session['request_token']  = nil
      session['request_secret'] = nil

      profile = Twitter::Base.new(oauth).verify_credentials
      account = Account.find_or_create_by_username(profile.screen_name)
      
      account.update_attributes({
        :atoken  => oauth.access_token.token, 
        :asecret => oauth.access_token.secret,
        :user => current_user
      })
      
      flash[:success] = "Your account was successfully added to #{Configuration.app.title}!"
      redirect_to app_user_account_path(account.username)
    end
    
    def show
      @statuses = @account.client.friends_timeline(:page => params[:page])
    end
    
    def edit
    end
    
    def update
      if @account.update_attributes(params[:account])
        # Additional bit.ly test
        if !@account.link_shortening_available?
          flash[:success] = "Account was successfuly updated."
          redirect_to edit_app_user_account_path(@account)
        else
          if @account.links.build.test!
            flash[:success] = "Account was successfuly updated."
            redirect_to edit_app_user_account_path(@account)
          else
            flash[:success] = "Your details were saved however your Bit.ly credentials seem incorrect. Please check them and try again."
            @account.reset_bitly_credentials!
            render :action => "edit"
          end
        end
      else
        flash[:failure] = "An error occured whilst saving your account. Please check the information you entered and try again."
        render :action => "edit"
      end
    end
    
    def destroy
      @account.destroy
      flash[:success] = "Your account '#{@account.username}' was successfully removed from #{Configuration.app.title}."
      redirect_to app_user_path
    end

    private
    def get_account
      @account = @user.accounts.find_by_username(params[:id])
    end
    
    def oauth
      @oauth ||= Twitter::OAuth.new(Configuration.twitter.auth_token, Configuration.twitter.auth_secret, :sign_in => true)
    end
    
  end
end
