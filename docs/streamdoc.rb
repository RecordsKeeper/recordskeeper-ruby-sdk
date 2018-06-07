# = Stream Class Usage
# This is a library to work with streams in RecordsKeeper Blockchain.
# You can publish address, retrieve data, retrieve with address, retrieve with key, verify data and retrieve items.
# ---------
# == Libraries
# Require these ruby libraries first to get started with the functionality.
#  require 'rubygems'
#  require 'httparty'
#  require 'json'
#  require 'binary_parser'
#  require 'yaml'
#  require 'hex_string'
# -----------------
# == Create Connection
# Entry point for accessing Blockchain class resources.
# * URL: Url to connect to the chain ([RPC Host]:[RPC Port])
# * Chain-name: Name of the chain
#  cfg = YAML::load(File.open('sample_config.yaml','r'))		# Loads the configuration file
# * Set a *network* value to change the network-type
#  network = cfg['testnet']                    # Network variable to store the network that you want to access
# **NOTE:* Default network is *Test-net* ( i.e., you can set it to either testnet or mainnet).
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
# = class Stream
# Stream class is used to call stream related functions to publish address, retrieve data, retrieve with address, retrieve with key, verify data and retrieve items.
# === 1. publish address, stream, key, data
# This function retrieves information about the chain.
#	publish address, stream, key, data
#	transacid = publish address, stream, key, data	# Function call
#
#	puts transacid               # Prints txid.
# === 2. retrieve stream, txid
# This function retrieves information related to your node.
# 	retrieve stream, txid
#	data = retrieve stream, txid	 # Function call
#
# 	puts data				# Prints raw_data.
# === 3. retrieveWithAddress stream, address
# This function lists all the permissions.
# 	retrieveWithAddress stream, address
#	retadd = retrieveWithAddress stream, address	# Function call
#
# 	puts retadd				# Prints key, data and txid.
# === 4. retrieveWithKey stream, key
# This function retrieves information related to your node.
# 	retrieveWithKey stream, key
#	retkey = retrieveWithKey stream, key		# Function call
#
# 	puts retkey				# Prints publisher, data and txid.
# === 5. verifyData stream, data, count
# This function retrieves information related to your node.
# 	verifyData stream, data, count
#	verifystat = verifyData stream, data, count		# Function call
#
# 	puts verifystat				# Prints result.
# === 6. retrieveItems stream, count
# This function retrieves information related to your node.
# 	retrieveItems stream, count
#	retitem = retrieveItems stream, count		# Function call
#
# 	puts retitem				# Prints address, key_value, raw_data and txid.
class Stream
end
