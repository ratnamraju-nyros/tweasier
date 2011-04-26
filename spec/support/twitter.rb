TWITTER_GEM_VERSION = "0.8.1"
TWITTER_GEM_PATH    = File.expand_path(File.join(RAILS_ROOT, "vendor", "gems", "twitter-#{TWITTER_GEM_VERSION}"))

# Get json fixture file
def json_fixture(filename)
  return "" if filename == ""
  fixture_path = File.expand_path(File.join(TWITTER_GEM_PATH, "test", "fixtures", "#{filename}.json"))
  File.read(fixture_path)
end

def twitter_url(url)
  url =~ /^http/ ? url : "http://twitter.com#{url}"
end

# Stub out fakeweb requests
def stub_get(url, filename, status=nil)
  options = {:body => json_fixture(filename)}
  options.merge!({:status => status}) unless status.nil?
  
  FakeWeb.register_uri(:get, twitter_url(url), options)
end

def stub_post(url, filename)
  FakeWeb.register_uri(:post, twitter_url(url), :body => json_fixture(filename))
end

def stub_put(url, filename)
  FakeWeb.register_uri(:put, twitter_url(url), :body => json_fixture(filename))
end

def stub_delete(url, filename)
  FakeWeb.register_uri(:delete, twitter_url(url), :body => json_fixture(filename))
end
