# Getting started with your own AWeber Account
# ============================================

# First, go to http://labs.aweber.com, get a free AWeber Labs
# account and create an App.
@oauth = AWeber::OAuth.new("consumer_key", "consumer_secret")

# Go to URL outputed by the following, authorize your account
# and copy the verification code
@oauth.request_token.authorize_url
@oauth.authorize_with_verifier("verification_code")

# Save your Access Tokens for later use, you won't need
# to do all this once you have it. Check out
# with_access_tokens.rb for an example of this.
#
# DATASTORE << @oauth.access_token.token
# DATASTORE << @oauth.access_token.secret

@aweber = AWeber::Base.new(@oauth)
# An account is the root resource for all AWeber data
@account = @aweber.account

@account.lists
@account.lists[1].web_forms
# etc
