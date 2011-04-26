require 'machinist/active_record'
require 'sham'
require 'faker'

module Feedback

  PollEntry.blueprint do
    answer { PollAnswer.make }
    user { User.make }
  end

end
