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
#	retadd = JSON.parse retrieveWithAddress stream, address		# Function call
#	
# 	puts retadd['key']				# Prints key, data and txid.
#	puts retadd['raw_data']			# prints raw data
#	puts retadd['txid']				# prints transaction id
# === 4. retrieveWithKey stream, key
# This function retrieves information related to your node.
# 	retrieveWithKey stream, key
#	retkey = JSON.parse retrieveWithKey stream, key		# Function call
#	
# 	puts retkey['publisher']				# prints publisher
#	puts retkey['raw_data']					# prints raw data
#	puts retkey['txid']						# prints transaction id
# === 5. verifyData stream, data, count
# This function retrieves information related to your node.
# 	verifyData stream, data, count
#	verifystat = verifyData stream, data, count		# Function call
#	
# 	puts verifystat				# Prints result.
# === 6. retrieveItems stream, count
# This function retrieves information related to your node.
# 	retrieveItems stream, count
#	retitem = JSON.parse retrieveItems stream, count		# Function call
#	
# 	puts retitem['address']				# prints address
#	puts retitem['key_value']			# prints key_value
#	puts retitem['raw_data']			# prints raw_data
#	puts retitem['txid']				# prints transaction id
class Stream
end