# ----------------------------------------------------
# Polls
# ----------------------------------------------------

module Feedback
  
  p = Poll.create(:title => "Would you use bulk direct messaging much?")
  p.answers.build(:title => "Yes, please build this!").save
  p.answers.build(:title => "Not really, leave it!").save
  
  p = Poll.create(:title => "Whats the main problem with this site?")
  p.answers.build(:title => "Too slow").save
  p.answers.build(:title => "Doesn't look very nice").save
  p.answers.build(:title => "Spam is an issue").save
  p.answers.build(:title => "Too expensive").save
  
  p = Poll.create(:title => "Does Tweasier rock?!")
  p.answers.build(:title => "Yes, damn right!").save
  p.answers.build(:title => "It could be better...").save
  
end

# ----------------------------------------------------
# Rule Conditions
# ----------------------------------------------------

module App
  
  SearchConditionType.create(:label => "contains", :operator => "")
  SearchConditionType.create(:label => "does not contain", :operator => "-")
  SearchConditionType.create(:label => "to", :operator => "to:")
  SearchConditionType.create(:label => "from", :operator => "from:")
  SearchConditionType.create(:label => "referencing", :operator => "@")
  SearchConditionType.create(:label => "happy", :operator => ":)", :value_required => false)
  SearchConditionType.create(:label => "not happy", :operator => ":(", :value_required => false)
  SearchConditionType.create(:label => "links only", :operator => "filter:links", :value_required => false)
  SearchConditionType.create(:label => "source only", :operator => "source:")
  SearchConditionType.create(:label => "near", :operator => "geocode:", :processor => "geocode")
  
end
