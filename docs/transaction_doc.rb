# = Transaction Class Usage
# This is a library to work with RecordsKeeper transactions.
# You can send transaction, create raw transaction, sign raw transaction, send raw transaction, send signed transaction, retrieve transaction information and calculate transaction’s fees by using transaction class. You just have to pass parameters to invoke the pre-defined functions.
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
# = class Transaction
# Transaction class is used to call transaction related functions like create raw transaction, sign transaction, send transaction , retrieve transaction and verify transaction functions which are used to create raw transactions, send transactions, sign transactions, retrieve transactions and verify transactions on the RecordsKeeeper Blockchain.
# === 1. sendTransaction sender_address, reciever_address, amount
# This function is used to send transaction by passing reciever’s address, sender’s address and amount.
#
# You have to pass these three arguments to the sendTransaction function call:
# * Transaction’s sender address
# *	Transaction’s reciever address
# *	Amount to be sent in transaction
#
#		txid = sendTransaction sender_address, reciever_address, amount		# Function call
#
#		puts txid                  # prints transaction id of the sent transaction
# === 2. sendSignedTransaction
# This function  is used to send transaction by passing reciever’s address, sender’s address, private key of sender and amount. In this function private key is required to sign transaction.
#
# You have to pass these four arguments to the sendSignedTransaction function call:
# * Transaction’s sender address
# * Transaction’s reciever address
# * Amount to be sent in transaction
# * Private key of the sender’s address
#
#	 	transaction_id = sendSignedTransaction		# Function call
#
#		puts transaction_id        # prints transaction id of the signed transaction
# === 3. createRawTransaction sender_address, reciever_address, amount
# This function is used to create raw transaction by passing reciever’s address, sender’s address and amount.
#
# You have to pass these three arguments to the sendTransaction function call:
# * Transaction’s sender address
# *	Transaction’s reciever address
# *	Amount to be sent in transaction
#
#		tx_hex = createRawTransaction sender_address, reciever_address, amount		# Function call
#
#		puts tx_hex      # prints transaction hex of the raw transaction
# === 4. signRawTransaction tx_hex, private_key
# This function retrieves is used to sign raw transaction by passing transaction hex of the raw transaction and the private key to sign the raw transaction.
#
# You have to pass these three arguments to the signRawTransaction function call:
# * Transaction hex of the raw transaction
# * Private key to sign raw transaction
#
#		signed_hex = signRawTransaction txHex, private_key		# Function call
#
#		puts signed_hex      # prints signed transaction hex of the raw transaction
# === 5. sendRawTransaction signed_txHex
# This function is used to send raw transaction by passing signed transaction hex of the raw transaction.
#
# You have to pass the signed transaction hex of the raw transaction.
#
#		tx_id = sendRawTransaction signed_txHex		# Function call
#
#		puts tx_id     # prints transaction id of the raw transaction
# === 6. retrieveTransaction tx_id
# This function is used to retrieve transaction’s information by passing transaction id to the function.
#
# You have to pass the transaction id of the transaction you want to retrieve.
#
#		retrievedinfo = JSON.parse retrieveTransaction tx_id		# Function call
#
#		puts retrievedinfo['sent_data']                   #prints sent data
#		puts retrievedinfo['sent_amount']                 #prints sent amount
#		puts retrievedinfo['reciever_address']            #prints reciever's address
# === 7. getFee address, tx_id
# This function is used to calculate transaction’s fee by passing transaction id and sender’s address to the function.
#
# You have to pass these two arguments to the getFee function call:
# * Transaction id of the transaction you want to calculate fee for
# * Sender’s address
#
#		fees = getFee address, tx_id		# Function call
#
#		puts fees                    #prints fees consumed in the verified transaction

class Transaction
end