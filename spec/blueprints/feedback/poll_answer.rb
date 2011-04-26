require 'machinist/active_record'
require 'sham'
require 'faker'

module Feedback

  PollAnswer.blueprint do
    title { Sham.title }
    poll { Poll.make }
  end

end
