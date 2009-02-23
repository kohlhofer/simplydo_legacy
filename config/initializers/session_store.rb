# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_simplydo_session',
  :secret      => '4f63c8ead726c03fdbb2d719d895d36b484004455fcad22a7acf02ebf02176013f87349f89074917fe1819a50dcd196f2ca34b150aca10cc0bf0f6b960f3aefb'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
