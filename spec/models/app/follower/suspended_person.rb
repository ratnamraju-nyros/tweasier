# --------------------------------------------------
# Model Spec: SuspendedPerson
# --------------------------------------------------

module App
  module Follower
    describe SuspendedPerson do
      
      before(:all) do
        User.destroy_all
        Account.destroy_all
      end

      before(:each) do
        user = make_user!
        @account = user.accounts.first
        @search  = @account.searches.first
        @suspended_person = @search.followed_people.first
      end

      it "should belong to an account" do
        @suspended_person.should belong_to(:account)
      end
      
      it "should belong to a search" do
        @suspended_person.should belong_to(:search)
      end
      
      it "should validate presence of account" do
        @suspended_person.should validate_presence_of(:account)
      end
      
      it "should delegate the user information to the serialized user YAML object" do
        screen_name     = @suspended_person.user.screen_name
        name            = @suspended_person.user.name
        followers_count = @suspended_person.user.followers_count
        statuses_count  = @suspended_person.user.statuses_count
        friends_count   = @suspended_person.user.friends_count
        
        @suspended_person.screen_name.should     == screen_name
        @suspended_person.name.should            == name
        @suspended_person.followers_count.should == followers_count
        @suspended_person.statuses_count.should  == statuses_count
        @suspended_person.friends_count.should   == friends_count
      end
    end
  end
end
