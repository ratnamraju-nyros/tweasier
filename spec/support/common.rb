# Helper methods
def login!
  user = make_user!
  controller.stub!(:current_user).and_return(user)
end

# Defines builtin helper methods that custom helpers may rely on,
# will define those methods within the current #describe block (hence self).
def define_rails_helper_methods!
  self.stub!(:render).and_return("rendered content")
end

# creates a user with associated accounts
def make_user!(attributes={})
  User.make(attributes) do |user|
    user.accounts.make do |account|
      account.searches.make
      4.times { account.links.make }
      account.searches.first.followed_people.make
      account.followed_people.make
    end
  end
end
