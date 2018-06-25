# = Assets Class Usage
# This is a library to work with RecordsKeeper assets.
# You can create new assets and list all assets by using Assets class. You just have to pass parameters to invoke the pre-defined functions.
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
# = class Assets
# Assets class is used to call assets related functions like create assets and list assets functions which are used on the RecordsKeeeper Blockchain.
# === 1. createAsset 
# This function is used to create or issue an asset.
#	txid = createAsset address, asset_name, asset_qty        # Function call
#
#	puts txid                  # prints tx id of the issued asset
# === 2. retrieveAssets
# This function is used to list all assets, no of assets, issued quantity and issued transaction id of all the assets on RecordsKeeper Blockchain.
#	retrievedinfo = JSON.parse retrieveAssets       # Function call
#
#	puts retrievedinfo['asset_name']       # prints all the addresses of the wallet
#	puts retrievedinfo['asset_count']      # prints the address count
#	puts retrievedinfo['issue_qty']        # prints assets issued quantity
#	puts retrievedinfo['issue_id']         # prints assets issued transaction id
# === 3. sendAsset 
# This function is used to send an asset.
#	txid = sendAsset address, asset_name, asset_qty        # Function call
#
#	puts txid                  # prints tx id of the sent asset
class Assets
end
