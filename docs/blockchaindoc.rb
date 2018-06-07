# = Blockchain Class Usage
# This is a library to work with Blockchain in RecordsKeeper Blockchain.
# You can retrieve information about the chain and node, list all the permissions and the pending transactions and check your node's balance.
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
# = class Blockchain
# Blockchain class is used to call blockchain related functions to retrieve information about the chain and node, list all the permissions and the pending transactions and check your node's balance.
# === 1. getChainInfo
# This function retrieves information about the chain.
#	getChainInfo
#	chainInfo = getChainInfo			 # Function call
#
#	puts chainInfo               # Prints chain_protocol, chain_description, root_stream, max_blocksize, default_networkport, default_rpcport, mining_diversity and chain_name.
# === 2. getNodeInfo
# This function retrieves information related to your node.
# 	getNodeInfo
#	nodeInfo = getNodeInfo			# Function call
#
# 	puts nodeInfo				# Prints node_balance, synced_blocks, node_address and difficulty.
# === 3. permissions
# This function lists all the permissions.
# 	permissions
#	listpermissions = permissions			# Function call
#
# 	puts listpermissions				# Prints the list of permissions.
# === 4. getpendingTransactions
# This function retrieves information related to your node.
# 	getpendingTransactions
#	pentransac = getpendingTransactions				# Function call
#
# 	puts pentransac				# Prints transaction_count and the transactions.
# === 5. checkNodeBalance
# This function retrieves information related to your node.
# 	checkNodeBalance
#	nodeBal = checkNodeBalance			# Function call
#
# 	puts nodeBal				# Prints node's balance amount.
class Blockchain
end
