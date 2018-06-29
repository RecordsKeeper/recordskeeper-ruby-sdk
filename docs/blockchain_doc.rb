# = Blockchain Class Usage
# This is a library to work with Blockchains in RecordsKeeper.
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
# = class Blockchain
# Blockchain class is used to call blockchain related functions to retrieve information about the chain and node, list all the permissions and the pending transactions and check your node's balance.
# === 1. getChainInfo
# This function retrieves information about the chain.
#	getChainInfo						
#	chainInfo = JSON.parse getChainInfo			 # Function call	   
#      
#	puts chainInfo['chain_protocol']			# prints chain-protocol
#	puts chainInfo['chain_description']			# prints chain-description
#	puts chainInfo['root_stream']				# prints root-stream-name
#	puts chainInfo['max_blocksize']				# prints maximum-block-size
#	puts chainInfo['default_networkport']		# prints default-network-port
#	puts chainInfo['default_rpcport']			# prints default-rpc-port
#	puts chainInfo['mining_diversity']			# prints mining-diversity
#	puts chainInfo['chain_name']				# prints chain-name
# === 2. getNodeInfo
# This function retrieves information related to your node.
# 	getNodeInfo
#	nodeInfo = JSON.parse getNodeInfo			# Function call
#	
# 	puts nodeInfo['node_balance']			# prints balance
#	puts nodeInfo['synced_blocks']			# prints synced-blocks
#	puts nodeInfo['node_address']			# prints nodeaddress
#	puts nodeInfo['difficulty']				# prints difficulty
# === 3. permissions
# This function lists all the permissions.
# 	permissions
#	listpermissions = permissions			# Function call
#	
# 	puts listpermissions				# Prints the list of permissions.
# === 4. getpendingTransactions
# This function retrieves information related to your node.
# 	getpendingTransactions
#	pentransac = JSON.parse getpendingTransactions				# Function call
#	
# 	puts pentransac['tx_count']				# prints transaction count
#	puts pentransac['tx']					# prints the pending transactions
# === 5. checkNodeBalance
# This function retrieves information related to your node.
# 	checkNodeBalance
#	nodeBal = checkNodeBalance			# Function call
#	
# 	puts nodeBal				# Prints node's balance amount.
class Blockchain
end