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
#  cfg = YAML::load(File.open('sample_config.yaml','r'))		# Loads the configuration file
# * Set a *network* value to change the network-type
#  network = cfg['testnet']                    # Network variable to store the network that you want to access
# **NOTE:* Default network is *Test-net*, you can change it to mainnet or testnet
# Check the network type for url and chain name:
#  if @network==cfg['testnet']
#      @url = cfg['testnet']['url']
#      @chain = cfg['testnet']['chain']
#  else
#      @url = cfg['mainnet']['url']
#      @chain = cfg['mainnet']['chain']
#  end
# -------------------
# == Node Authentication
# Import values from config file.
# * User name: The rpc user is used to call the APIs.
# * Password: The rpc password is used to authenticate the APIs.
# * Check the network type for username and password:
#  if @network==cfg['testnet']
#       @user = cfg['testnet']['rkuser']
#       @password = cfg['testnet']['passwd']
#  else
#       @user = cfg['mainnet']['rkuser']
#       @password = cfg['mainnet']['passwd']
#  end
# Now we have node authentication credentials.
# ------------
# = class Assets
# Assets class is used to call assets related functions like create assets and list assets functions which are used on the RecordsKeeeper Blockchain.
# === 1. createAsset
# This function is used to create or issue an asset.
#	txid = createAsset         # Function call
#
#	puts txid                  # prints tx id of the issued asset
# === 2. retrieveAssets
# This function is used to list all assets, no of assets, issued quantity and issued transaction id of all the assets on RecordsKeeper Blockchain.
#	asset_name, issue_id, issue_qty, asset_count = retrieveAssets       # Function call
#
#	puts asset_name       # prints all the addresses of the wallet
#	puts asset_count      # prints the address count
#	puts issue_qty        # prints assets issued quantity
#	puts issue_id         # prints assets issued transaction id
class Assets
end
