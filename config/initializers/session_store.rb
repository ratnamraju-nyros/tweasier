# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_tweasier_session',
  :secret      => '00504c45d7aa99075ddfbc3e5f1ab22eeb67b8e05612126dd3262af837ed06b983494f06292c42f3fa14d2cafeed7e5d466d34dfe51b82f61123a3a641633044'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
