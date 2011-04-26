# --------------------------------------------------
# Model Spec: FollowedPerson
# --------------------------------------------------

module App
  module Follower
    describe FollowedPerson do
      
      before(:all) do
        User.destroy_all
        Account.destroy_all
      end

      before(:each) do
        user = make_user!
        @account = user.accounts.first
        @search  = @account.searches.first
        @followed_person = @search.followed_people.first
      end

      it "should belong to an account" do
        @followed_person.should belong_to(:account)
      end
      
      it "should belong to a search" do
        @followed_person.should belong_to(:search)
      end
      
      it "should validate presence of account" do
        @followed_person.should validate_presence_of(:account)
      end
      
      it "should delegate the user information to the serialized user YAML object" do
        screen_name     = @followed_person.user.screen_name
        name            = @followed_person.user.name
        followers_count = @followed_person.user.followers_count
        statuses_count  = @followed_person.user.statuses_count
        friends_count   = @followed_person.user.friends_count
        
        @followed_person.screen_name.should     == screen_name
        @followed_person.name.should            == name
        @followed_person.followers_count.should == followers_count
        @followed_person.statuses_count.should  == statuses_count
        @followed_person.friends_count.should   == friends_count
      end
    end
  end
end
