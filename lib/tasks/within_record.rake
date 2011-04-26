namespace :within_record do
  desc 'Search condition type'
  task :setup => :environment do    
    SearchConditionType.create(:operator => 'within:',   :label => 'within this distance', :value_required=>1,:processor=>'within')
    end
  end

