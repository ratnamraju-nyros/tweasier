# --------------------------------------------------
# Model Spec: Person
# --------------------------------------------------

module App
  module Follower
    describe Person do
      
      before(:all) do
        User.destroy_all
        Account.destroy_all
      end

      before(:each) do
        user = make_user!
        @account = user.accounts.first
        @search  = @account.searches.first
        @person = @search.followed_people.first
      end

      it "should belong to an account" do
        @person.should belong_to(:account)
      end
      
      it "should belong to a search" do
        @person.should belong_to(:search)
      end
      
      it "should validate presence of account" do
        @person.should validate_presence_of(:account)
      end
      
      it "should delegate the user information to the serialized user YAML object" do
        screen_name     = @person.user.screen_name
        name            = @person.user.name
        followers_count = @person.user.followers_count
        statuses_count  = @person.user.statuses_count
        friends_count   = @person.user.friends_count
        
        @person.screen_name.should     == screen_name
        @person.name.should            == name
        @person.followers_count.should == followers_count
        @person.statuses_count.should  == statuses_count
        @person.friends_count.should   == friends_count
      end
    end
  end
end
