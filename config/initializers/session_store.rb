# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_sokuhame_session',
  :secret      => '8d5c9c9eae33a16ec85e6815606d2b5af567fe0b1acde47b900766172126923edfbde64e48de9e69af6bfd9084f28219d76ed068cc1557b41300232616820871'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
