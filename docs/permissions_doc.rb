# = Permissions Class Usage
# This is a library to work with RecordsKeeper permissions.
# You can grant and revoke permissions like connect, send, receive, create, issue, mine, activate, admin by using Assets class. You just have to pass parameters to invoke the pre-defined functions.
# ---------
# == Libraries
# Require these ruby libraries first to get started with the functionality.
#  require 'rubygems'
#  require 'httparty'
#  require 'json'
#  require 'binary_parser'
#  require 'yaml'
# -----------------
# == Create Connection
# Entry point for accessing Address class resources.
# * URL: Url to connect to the chain ([RPC Host]:[RPC Port])
# * Chain-name: chain name
# 	 	cfg = YAML::load(File.open('sample_config.yaml','r'))		# Loads the configuration file 
# * Set a *network* value.
#  		network = cfg['network']                    # Network variable to store the network that you want to access
# * Set url and chain name:
#      @url = cfg['network']['url']
#      @chain = cfg['network']['chain']
# -------------------
# == Node Authentication
# Import values from config file.
# * User name: The rpc user is used to call the APIs.
# * Password: The rpc password is used to authenticate the APIs.
# * Set the rpc username and password:
#       @user = cfg['network']['rkuser']
#       @password = cfg['network']['passwd']
# Now we have node authentication credentials.
# ------------
# = class Permissions
# Permissions class is used to call permissions related functions like grant and revoke permissions for an address functions which are used on the RecordsKeeeper Blockchain.
# === 1. grantPermission address, permissions
# This function is used to grant permissions like connect, send, receive, create, issue, mine, activate, admin to an address on RecordsKeeper Blockchain.
#
# You have to pass these two arguments to the grantPermission function call:
# * Permissions: list of comma-seperated permissions passed as a string
# * Address: to which you have to grant permission
#	result = grantPermission address, permissions
#
#	puts txid                  # prints response of the grant permision transaction
# === 2. revokePermission address, permissions
# This function is used to revoke permissions like connect, send, receive, create, issue, mine, activate, admin to an address on RecordsKeeper Blockchain.
#	
# You have to pass these two arguments to the grantPermission function call:
# * Permissions: list of comma-seperated permissions passed as a string
# * Address: to which you have to grant permission
#	result = revokePermission address, permissions
#
#	puts result                # prints response of the revoke permision transaction
class Permissions
end
