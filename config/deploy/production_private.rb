# -------------------------------------
# Production env deploy file
# -------------------------------------

set :user,        "twdeploy"
set :runner,      "twdeploy"
set :application, "private.tweasier.com"
set :deploy_to,  "/home/#{user}/sites/#{application}/"
set :scm,        "git"
set :repository, "git@server1.hawkinsking.com:tweasier.git"

set :branch,     "legacydjh" #0.9.9

set :user,        "twdeploy"
set :runner,      "twdeploy"
set :giternal_binary, "giternal"
set :whenever_binary, "whenever"

set  :main_server, "server2.tweasier.com"
role :app, main_server
role :web, main_server
role :db,  main_server, :primary => true

set :host, "private.tweasier.com"
