# --------------------------------------------------
# Model Spec: Links
# --------------------------------------------------

module App
  describe Link do
    
    before(:all) do
      User.destroy_all
      Account.destroy_all
      Link.destroy_all
    end
    
    before(:each) do
      user     = make_user!
      @account = user.accounts.first
      @link    = @account.links.first
    end
    
    it "should be valid" do
      @link.should be_valid
    end

    it "should belong to account" do
      @link.should belong_to(:account)
    end
    
    it "should delegate token and secret to account" do
      @link.should respond_to(:bitly_token)
      @link.should respond_to(:bitly_secret)
      
      @account.bitly_token  = "sometoken"
      @account.bitly_secret = "somesecret"
      
      @account.save
      
      @link.bitly_token.should == "sometoken"
      @link.bitly_secret.should == "somesecret"
    end
    
    it "should present a valid bit.ly client on #client" do
      @link.client.should be_instance_of(Bitly::Client)
    end
    
    it "should fail to pass #test! with bad credentials" do
      @account.bitly_token  = ""
      @account.bitly_secret = ""
      @account.save
      
      @link.test!.should be_false
    end
    
    it "should success to pass #test! with valid credentials" do
      FakeWeb.register_uri(:get, "http://api.bit.ly/shorten?apiKey=goodsecret&login=goodtoken&history=1&version=2.0.1&longUrl=http%3A%2F%2Ftest.com", :body => '{ "errorCode": 0, "errorMessage": "", "results": { "http://test.com": { "hash": "31IqMl", "shortKeywordUrl": "", "shortUrl": "http://bit.ly/15DlK", "userHash": "15DlK" } }, "statusCode": "OK" }', :content_type => "text/javascript")
      
      @account.bitly_token  = "goodtoken"
      @account.bitly_secret = "goodsecret"
      @account.save
      
      @link.test!.should be_true
    end
    
    it "should successfully shorten a url via bit.ly on shorten!" do
      FakeWeb.register_uri(:get, "http://api.bit.ly/shorten?apiKey=goodsecret&login=goodtoken&history=1&version=2.0.1&longUrl=http%3A%2F%2Fblog.josh-nesbitt.net", :body => '{ "errorCode": 0, "errorMessage": "", "results": { "http://blog.josh-nesbitt.net": { "hash": "31IqMl", "shortKeywordUrl": "", "shortUrl": "http://bit.ly/15DlK", "userHash": "15DlK" } }, "statusCode": "OK" }', :content_type => "text/javascript")
      
      @account.bitly_token  = "goodtoken"
      @account.bitly_secret = "goodsecret"
      @account.save
      
      link = @account.links.build :long_url => "http://blog.josh-nesbitt.net"
      link.shorten!.unique_hash.should == "31IqMl"
    end
    
    it "should refresh the statistics on #refresh_statistics!" do
      FakeWeb.register_uri(:get, "http://api.bit.ly/shorten?apiKey=goodsecret&login=goodtoken&history=1&version=2.0.1&longUrl=http%3A%2F%2Fblog.josh-nesbitt.net", :body => '{ "errorCode": 0, "errorMessage": "", "results": { "http://blog.josh-nesbitt.net": { "hash": "31IqMl", "shortKeywordUrl": "", "shortUrl": "http://bit.ly/15DlK", "userHash": "15DlK" } }, "statusCode": "OK" }', :content_type => "text/javascript")
      FakeWeb.register_uri(:get, "http://api.bit.ly/stats?apiKey=goodsecret&hash=15DlK&login=goodtoken&version=2.0.1", :body => '{ "errorCode": 0, "errorMessage": "", "results": { "clicks": 5947, "hash": "31IqMl", "referrers": { "": { "/index.html": 1, "None": 5, "direct": 4090 }, "alpha.smx.local": { "/compositions": 1 }, "api.bit.ly": { "/shorten": 3 }, "articlair.com": { "": 1 }, "benny-web": { "/jseitel/bitly/install.html": 1 }, "bit.ly": { "/": 4, "/app/demos/info.html": 261, "/app/demos/stats.html": 818, "/app/demos/statsModule.html": 26, "/info/14tP6": 2, "/info/15DlK": 1, "/info/27I9Ll": 1, "/info/31IqMl": 4, "/info/8IN50s": 1, "/info/J066u": 1, "/info/SiNn6": 1, "/info/hic4E": 1 }, "code.google.com": { "/p/bitly-api/wiki/ApiDocumentation": 3 }, "conxel.com": { "/tweetelito/": 1 }, "dev.chartbeat.com": { "/static/bitly.html": 1 }, "dev.unhub.com": { "/pnG8/": 1 }, "friends.myspace.com": { "/index.cfm": 1 }, "home.myspace.com": { "/index.cfm": 3 }, "hootsuite.com": { "/dashboard": 1 }, "iconfactory.com": { "/twitterrific": 5 }, "klout.net": { "/profiledetail.php": 1 }, "localhost": { "/BuzzMeter/bitly/": 1, "/New Folder/test1.php": 1, "/SampleWeb/URLShortener.aspx": 1, "/index2.html": 1, "/tbazar/bitley.php": 1 }, "localhost:3246": { "/urlcompress/default.aspx": 1 }, "localhost:8888": { "/tweetlytics/ui.details.php": 1 }, "longurl.org": { "": 1 }, "m.facebook.com": { "/home.php": 2, "/stories.php": 1 }, "m.twitter.com": { "/": 5, "/broadwayallday": 1 }, "mail.google.com": { "/mail/": 1 }, "partners.bit.ly": { "/sd": 3, "/td": 63 }, "powertwitter.me": { "/": 5 }, "quietube.com": { "/getbitly.php": 1 }, "search.twitter.com": { "/search": 11 }, "sfbay.craigslist.org": { "/sfc/rnr/891043787.html": 8 }, "spreadsheets.google.com": { "/ccc": 47, "/ccc2": 1 }, "strat.corp.advertising.com": { "/brandmaker/bitly.php": 4 }, "t4nk.org": { "": 2 }, "taggytext.com": { "/ganja": 1 }, "twitter.com": { "": 1, "/": 162, "/40GLOCC": 4, "/40glocc": 2, "/BeatBullies": 2, "/CNNkimsegal": 1, "/FRANKTRIGG": 3, "/JanisMiller": 1, "/MusicSavvyMom": 1, "/PBAmanda": 1, "/Rachlovsherboys": 2, "/SuperTestAcct": 2, "/TattoosOn": 1, "/WilliamWoods": 1, "/ashleybellview": 1, "/bang590": 1, "/broadwayallday": 5, "/chienray": 2, "/demotpforte": 1, "/digijeff": 1, "/home": 27, "/hyperbets": 6, "/ibiboisms": 2, "/ihateatmfees": 1, "/joshbtweets": 1, "/kshanns": 1, "/matraji": 1, "/mbolaughlin": 1, "/munchpunchkin": 1, "/nathanfolkman": 1, "/pantaleonescu": 1, "/rubyisbeautiful": 1, "/search": 3, "/sparkerPants": 1, "/spdean": 1, "/timeline/home": 1, "/williamwoods": 1, "/yachay": 3, "/yachay/status/4447647278": 2 }, "twitter.mattz.dev.buddymedia.com": { "/twitter/": 1 }, "twitturls.com": { "/": 26 }, "twitturly.com": { "": 17, "/urlinfo/url/2168a5e81280538cdbf6ad4c4ab019db/": 1 }, "twubs.com": { "": 2 }, "uncc.facebook.com": { "/home.php": 1 }, "untiny.me": { "/": 2 }, "uploaddownloadperform.net": { "/Test/TestPage2": 1 }, "url.ly": { "/": 19, "/info/27I9Ll": 1, "/info/31IqMl": 3 }, "urly.local:3600": { "/": 7 }, "v2.blogg.no": { "/test.cfm": 1 }, "www.coveritlive.com": { "/index2.php": 1 }, "www.facebook.com": { "//jsusskind": 1, "/Jaywebs": 1, "/album.php": 2, "/chantellesamuels": 1, "/davidayling": 1, "/home.php": 76, "/joshblackman": 2, "/kathy.budhai": 2, "/maggie.oldmixon": 1, "/pages/Portland-Jamaica/The-Portland-Tribunal/89621771613": 4, "/photo.php": 1, "/photos/": 1, "/profile.php": 3, "/reqs.php": 1, "/thebetsyking": 2, "/tos.php": 1 }, "www.google.com": { "/search": 1, "/url": 1 }, "www.longurlplease.com": { "/": 3 }, "www.microblogbuzz.com": { "": 5 }, "www.mshare.net": { "/report/app": 1 }, "www.msplinks.com": { "/MDFodHRwOi8vYml0Lmx5LzRuVDdiQg==": 1 }, "www.new.facebook.com": { "/home.php": 1 }, "www.politibird.com": { "/new/": 2 }, "www.tongs.org.uk": { "": 1 }, "www.twitscoop.com": { "/": 1, "/search": 1 } } }, "statusCode": "OK" }', :content_type => "text/javascript")
      
      @account.bitly_token  = "goodtoken"
      @account.bitly_secret = "goodsecret"
      @account.save
      
      link = @account.links.build :long_url => "http://blog.josh-nesbitt.net"
      link.shorten!
      
      link.refresh_statistics!.cached_clickcount.should == 5947
      link.refresh_statistics!.cached_user_clickcount.should == 0
      link.refresh_statistics!.referrers.should include("search.twitter.com")
    end
  end
end
