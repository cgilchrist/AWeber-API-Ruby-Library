# Getting started with saved Access Tokens
# ========================================
@oauth = AWeber::OAuth.new("consumer_key", "consumer_secret")

# Use your saved Access Token token and secret to authorize.
#
# This is also how you'd authorize your users' accounts after
# they've authorized your app to access their data for the
# first time.
@oauth.authorize_with_access("token", "secret")

# Go on your merry way.
@aweber = AWeber::Base.new(@oauth)
@account = @aweber.account
@account.lists
@account.lists[1].web_forms
# etc