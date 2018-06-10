# Library to work with RecordsKeeper address class.
# You can generate new address, check all addresses, check address validity, check address permissions, check address balance
#   by using Address class. You just have to pass parameters to invoke the pre-defined functions.

# import rubygems, httparty, json, binary_parser, objspace and yaml
require 'rubygems'
require 'httparty'
require 'json'
require 'binary_parser'
require 'objspace'
require 'yaml'

# Address class to access address related functions
class Address

	# include HTTParty
	# Import values from configuration file.
	cfg = YAML::load(File.open('config.yaml','r'))
	@network = cfg['testnet']															# 'network' variable to store the network that you want to access
	if @network==cfg['testnet']
		@url = cfg['testnet']['url']
		@user = cfg['testnet']['rkuser']
		@password = cfg['testnet']['passwd']
		@chain = cfg['testnet']['chain']
	else
		@url = cfg['mainnet']['url']
		@user = cfg['mainnet']['rkuser']
		@password = cfg['mainnet']['passwd']
		@chain = cfg['mainnet']['chain']
	end

	def self.variable
		net = @network
		return net
	end

	# Function to generate new address on the node's wallet
	def self.getAddress

		auth = {:username => @user, :password => @password}
		options = {
			:headers => headers= {"Content-Type"=> "application/json","Cache-Control" => "no-cache"},
			:basic_auth => auth,
			:body => [ {"method":"getnewaddress","params":[],"jsonrpc":2.0,"id":"curltext","chain_name":@chain}].to_json
		}
		response = HTTParty.get(@url, options)
		out = response.parsed_response
		address = out[0]['result']
		return address															# Returns new address
	end

	# Function to generate a new multisignature address
	def self.getMultisigAddress nrequired, key		#getMultisigAddress() function definition

		key_list = key.split(",")
		auth = {:username => @user, :password => @password}
		options = {
			:headers => headers= {"Content-Type"=> "application/json","Cache-Control" => "no-cache"},
			:basic_auth => auth,
			:body => [ {"method":"createmultisig","params":[nrequired, key_list],"jsonrpc":2.0,"id":"curltext","chain_name":@chain}].to_json
		}
		response = HTTParty.get(@url, options)
		out = response.parsed_response
		address = out[0]['result']
		if address.nil?
			res = out[0]['error']['message']
		else
			res = out[0]['result']['address']
		end
		return res;																							#returns new multisig address
	end
	# newAddress = getMultisigAddress nrequired, key					# getMultisigAddress() function call
	# puts newAddress																					# Prints the new generated multisig address

	# Function to generate a new multisignature address on the node's wallet
	def self.getMultisigWalletAddress nrequired, key
		key_list = key.split(",")
		auth = {:username => @user, :password => @password}
		options = {
			:headers => headers= {"Content-Type"=> "application/json","Cache-Control" => "no-cache"},
			:basic_auth => auth,
			:body => [ {"method":"addmultisigaddress","params":[nrequired, key_list],"jsonrpc":2.0,"id":"curltext","chain_name":@chain}].to_json
		}
		response = HTTParty.get(@url, options)
		out = response.parsed_response
		address = out[0]['result']
		if address.nil?
			res = out[0]['error']['message']
		else
			res = out[0]['result']
		end
		return res;																										# Returns new multisig address
	end

	# Function to list all addresses and no of addresses on the node's wallet
	def self.retrieveAddresses
		auth = {:username => @user, :password => @password}
		options = {
			:headers => headers= {"Content-Type"=> "application/json","Cache-Control" => "no-cache"},
			:basic_auth => auth,
			:body => [ {"method":"getaddresses","params":[],"jsonrpc":2.0,"id":"curltext","chain_name":@chain}].to_json
		}
		response = HTTParty.get(@url, options)
		out = response.parsed_response
		address = out[0]['result']
		address_count = address.length
		address =[]
		for i in 0..address_count
			address.push(out[0]['result'][i])
		end
		return address, address_count;																			# Returns all addresses and address count
	end

	# Function to check if given address is valid or not
	def self.checkifValid address
		auth = {:username => @user, :password => @password}
		options = {
			:headers => headers= {"Content-Type"=> "application/json","Cache-Control" => "no-cache"},
			:basic_auth => auth,
			:body => [ {"method":"validateaddress","params":[address],"jsonrpc":2.0,"id":"curltext","chain_name":@chain}].to_json
		}
		response = HTTParty.get(@url, options)
		out = response.parsed_response
		validity = out[0]['result']['isvalid']
 		if validity
 			addressCheck = "Address is valid" 											# Prints that address is valid
 		else
 			addressCheck= "Address is invalid"											# Prints that address is invalid
		end
 		return addressCheck;																			# Return the address check status
	end

	# Function to check if given address has mining permission or not
	def self.checkifMineAllowed address
		auth = {:username => @user, :password => @password}
 		options = {
 			:headers => headers= {"Content-Type"=> "application/json","Cache-Control" => "no-cache"},
 			:basic_auth => auth,
 			:body => [ {"method":"validateaddress","params":[address],"jsonrpc":2.0,"id":"curltext","chain_name":@chain}].to_json
 		}
 		response = HTTParty.get(@url, options)
 		out = response.parsed_response
		permission = out[0]['result']['ismine']
		if permission
			permissionCheck = "Address has mining permission"										# Prints that address has mining permission
	 	else
		 	permissionCheck = "Address has not given mining permission"					# Prints that address hasn't been given mining permission
		end
		return permissionCheck;																								# Returns the permission status
	end

	# Function to check node address balance on RecordsKeeper Blockchain
	def self.checkBalance address
		auth = {:username => @user, :password => @password}
 		options = {
 			:headers => headers= {"Content-Type"=> "application/json","Cache-Control" => "no-cache"},
 			:basic_auth => auth,
 			:body => [ {"method":"getaddressbalances","params":[address],"jsonrpc":2.0,"id":"curltext","chain_name":@chain}].to_json
 		}
 		response = HTTParty.get(@url, options)
 		out = response.parsed_response
		balance = out[0]['result'][0]['qty']
 		return balance;																						# Returns balance of a particular node address
	end

	# Function to import address on RecordsKeeper Blockchain
	def self.importAddress public_address
		auth = {:username => @user, :password => @password}
		options = {
			:headers => headers= {"Content-Type"=> "application/json","Cache-Control" => "no-cache"},
			:basic_auth => auth,
			:body => [ {"method":"importaddress","params":[public_address, " ", false],"jsonrpc":2.0,"id":"curltext","chain_name":@chain}].to_json
		}
		response = HTTParty.get(@url, options)
		out = response.parsed_response
		result = out[0]['result']
		error = out[0]['error']
		if result.nil? && error.nil?
			resp = "Address successfully imported"												 # Prints that address has been succesfully imported
		elsif result.nil? && error!= nil
			resp = out[0]['error']['message']
		else
			resp = 0
		end
		return resp;
	end

end
