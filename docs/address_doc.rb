# = Address Class Usage
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
# = class Address
# Address class is used to call address related functions like generate new address, list all addresses and no of addresses on the node’s wallet, check if given address is valid or not, check if given address has mining permission or not and check a particular address balance on the node functions which are used on the RecordsKeeeper Blockchain.
# === 1. getAddress
# This function generates a new address on the node wallet.
#	getAddress						
#	newAddress = getAddress			 # Function call	   
#      
#	puts newAddress                  # prints a new address
# === 2. getMultisigAddress nrequired, key
# This function generates a new multisignature address.
#
# You have to pass these two arguments to the getMultisigAddress function call:
# * nrequired: To pass the no of signatures that are a must to sign a transaction.
# * key: To pass any number of comma-separated public addresses that are to be used with this multisig address as a single variable.
#	getMultisigAddress nrequired, key
#	newAddress = getMultisigAddress nrequired, key          # Function call
#
#	puts newAddress                           # prints a new address
# === 3. getMultisigWalletAddress nrequired, key
# This function generates a new multisignature address on the node's wallet.
#
# You have to pass these two arguments to the getMultisigWalletAddress function call:
# * nrequired: This variable is required to pass the number of signatures that are a must to sign a transaction.
# * key: This variable is required to pass a string of comma-separated public addresses that are to be used with this multisig address as a single variable.
#	getMultisigWalletAddress nrequired, key
# 	newAddress = getMultisigWalletAddress nrequired, key   		# Function call
#
# 	puts newAddress                           #prints a new address
# === 4. retrieveAddresses
# To list all the addresses and number of addresses on the node's wallet
# 	retrieveAddresses
# 	retrievedinfo = JSON.parse retrieveAddresses      		# Function call
#
# 	puts retrievedinfo['address']       # prints all the addresses of the wallet
#	puts retrievedinfo['address_count']	# prints the count of addresses in the wallet
# === 5. checkifValid address
# To check validity of the address
#
# You have to pass address as argument to the checkifValid function call:
# * Address: To check its validity.
#	checkifValid
#	addressC = checkifValid address                # Function call
#
# 	puts addressC      # prints validity
# === 6. checkifMineAllowed address
# To check if given address has mining permission or not
#
# You have to pass address as argument to the checkifMineAllowed function call:
# * Address: To check the permission status
# 	checkifMineAllowed address
#	permissionCheck = checkifMineAllowed address   # Function call
#
#	puts permissionCheck      # prints permission status of the given address
# === 7. checkBalance address
# To check address balance on a particular node
#
# You have to pass address as argument to the checkifMineAllowed function call:
# * Address: To check the balance
#	checkBalance address
#	address_balance = checkBalance address    # Function call
#
#	puts address_balance    # prints balance of the address
# === 8. importAddress public_address
# To import a non-wallet address on RecordsKeeeper Blockchain
#
# You have to pass address as argument to the importAddress function call:
# * Address: A non-wallet address to import on a particular node
#	importAddress public_address
#	response = importAddress public_address     # Function call
#
#	puts response    # prints response
class Address
end