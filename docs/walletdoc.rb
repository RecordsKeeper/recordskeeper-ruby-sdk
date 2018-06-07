# = Wallet Class Usage
# Library to work with RecordsKeeper wallet functionalities.
# You can create wallet, dump wallet into a file, backup wallet into a file, import wallet from a file, lock wallet, unlock wallet, change wallet’s password, retrieve private key, retrieve wallet’s information, sign and verify message by using wallet class. You just have to pass parameters to invoke the pre-defined functions.
# ---------
# == Libraries
# Require these ruby libraries first to get started with the functionality.
# 	require 'rubygems'
#  	require 'httparty'
#  	require 'json'
#  	require 'binary_parser'
#  	require 'yaml'
#  	require 'hex_string'
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
# = class Wallet
# Wallet class is used to call wallet related functions like create wallet, retrieve private key of wallet address, retrieve wallet’s information, dump wallet, lock wallet, unlock wallet, change wallet’s password, create wallet’s backup, import wallet’s backup, sign message and verify message functions on RecordsKeeeper Blockchain.
# === 1. createWallet
# This function is used to create wallet on RecordsKeeper blockchain
#		publicaddress, privatekey, publickey = createWallet
#
#		puts publicaddress                 # prints public address of the wallet
#		puts privatekey                    # prints private key of the wallet
#		puts publickey                     # prints public key of the wallet
# === 2. getPrivateKey
# This function is used to retrieve private key of the given address.
# 		privkey = getPrivateKey
#
#		puts privkey        # prints private key of the given address
# === 3. retrieveWalletinfo
# This function is used to retrieve node wallet’s information.
# 		balance, tx_count, unspent_tx = retrieveWalletinfo
#
#		puts balance      # prints wallet's balance
#		puts tx_count     # prints wallet transaction count
#		puts unspent_tx   # prints unspent wallet transactions
# === 4. backupWallet filename
# This function is used to create backup of the wallet.dat file.
#
# You have to pass filename; wallet’s backup file name
# 		result = backupWallet filename
#
#		puts result      # prints result
# It will return the response of the backup wallet function. The backup of the wallet is created in your chain’s directory and you can simply access your file by using same filename that you have passed with the backupwallet function. Creates a backup of the wallet.dat file in which the node’s private keys and watch-only addresses are stored. The backup is created in file filename. Use with caution – any node with access to this file can perform any action restricted to this node’s addresses.
# === 5. importWallet filename
# This function is used to import wallet’s backup file.
#
# You have to pass the filename; wallet’s backup file name.
#		result = importWallet filename
#
#		puts result    # prints result
# It will return the response of the import wallet function. It will import the entire set of private keys which were dumped (using dumpwallet) into file filename.
# === 6. dumpWallet filename
# This function is used to retrieve transaction’s information by passing transaction id to the function.
#
# You have to pass the filename; file name to dump wallet in.
# 		result = dumpWallet filename
#
#		puts result                  # prints result
# === 7. lockWallet password
# This function is used to verify transaction’s information by passing transaction id and sender’s address to the function.
#
# You have to pass password; password to lock the wallet.
# 		result = lockWallet password
#
#		puts result                    # prints result
# === 8. unlockWallet password, unlock_time
# This function is used to verify transaction’s information by passing transaction id and sender’s address to the function.
#
# You have to pass these two arguments to the unlockWallet function call:
# * Password: password to unlock the wallet
# * unlocktime: seconds for which wallet remains unlock
# 	result = unlockWallet password, unlock_time
#
#	puts result                    # prints result
# === 9. changeWalletPassword old_password, new_password
# This function is used to change wallet’s password and set new password.
#
# You have to pass these two arguments to the changeWalletPassword function call:
# * Old Password: old password of the wallet
# * New Password: new password of the wallet
# 	result = changeWalletPassword password, new_password
#
#	puts result                    # prints result
# === 10. signMessage private_key, message
# This function is used to change wallet’s password and set new password.
#
# You have to pass these two arguments to the signMessage function call:
# * Message: message to send
# * Private Key: private key of the sender’s wallet address
# 	signedMessage = signMessage private_key, message
#
#	puts signedMessage                 # prints signed message
# === 11. verifyMessage address, signedMessage, message
# This function is used to change wallet’s password and set new password.
#
# You have to pass these three arguments to the verifyMessage function call:
# * Message: message to send
# * Private Key: private key of the sender’s wallet address
# 	validity = verifyMessage address, signedMessage, message
#
#	puts validity                 # prints validity of the message
class Wallet
end
