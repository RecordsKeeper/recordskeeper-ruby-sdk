# = Block Class Usage
# This is a library to work with RecordsKeeper block information.
# You can generate new address, check all addresses, check address validity, check address permissions, check address balance by using Address class. You just have to pass parameters to invoke the pre-defined functions.
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
# = class Block
# Block class is used to call block related functions like blockinfo which is used to retrieve block details
# like block's hash value, size, nonce, transaction ids, transaction count, miner address, previous block hash,
# next block hash, merkleroot, blocktime and difficulty of the block for which you have made the query.
# === 1. blockinfo block_height
# * You have to pass the block height as an argument in the blockinfo function call (Block height: Height of the block of which you want to collect information.)
# * It will return transaction ids, transaction count, nonce, size, hash value, previous block's hash value, next block hash value, merkle root, difficulty, blocktime and miner address of the block.
#	blockinfo block_height							# Function call
#	tx_count, tx, miner, size, nonce, blockHash, prevblock, nextblock, merkleroot, blocktime, difficulty = blockinfo block_height
#
# 	puts tx_count      # prints transaction count of the block
# 	puts tx            # prints transaction ids of the block
# 	puts size          # prints size of the block
# 	puts blockHash     # prints hash value of the block
# 	puts nonce         # prints nonce of the block
# 	puts miner         # prints miner's address of the block
# 	puts nextblock     # prints next block's hash
# 	puts prevblock     # prints previous block's hash
# 	puts merkleroot    # prints merkle root of the block
# 	puts blocktime     # prints time at which block is mined
# 	puts difficulty    # prints difficulty of the block
# === 2. retrieveBlocks block_range
# * You have to pass the block's height as the argument to the retrieveBlocks function call (Block range: Range of the block of which you want to collect information)
# * It will return blockhash, miner address, blocktime and transaction count of the blocks.
#	retrieveBlocks block_range						# Function call
#	block_hash, miner_add, block_time, txcount = retrieveBlocks block_range
#
#	puts block_hash    # prints hash of the blocks
# 	puts miner_add     # prints miner of the blocks
# 	puts block_time    # prints block time of the blocks
# 	puts txcount       # prints transaction count of the blocks
class Block
end
