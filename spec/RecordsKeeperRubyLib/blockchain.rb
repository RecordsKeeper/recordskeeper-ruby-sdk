# 	Library to work with RecordsKeeper Blockchain.

#   You can retrieve blockchain information, node's information, node's balance, node's permissions, pending transaction details
# 		by using Blockchain class.
#   You just have to pass parameters to invoke the pre-defined functions."""

require 'rubygems'
require 'httparty'
require 'json'
require 'binary_parser'
require 'yaml'

module RecordsKeeperRubyLib
	class Blockchain

		cfg = YAML::load(File.open('config.yaml','r'))
		@network = cfg['network']
		@url = cfg['network']['url']
		@user = cfg['network']['rkuser']
		@password = cfg['network']['passwd']
		@chain = cfg['network']['chain']

		def self.variable
			net = @network
			return net
		end

		# Function to retrieve RecordsKeeper Blockchain parameters
		def self.getChainInfo
			auth = {:username => @user, :password => @password}
			options = {
				:headers => headers= {"Content-Type"=> "application/json","Cache-Control" => "no-cache"},
				:basic_auth => auth,
				:body => [ {"method":"getblockchainparams","params":[],"jsonrpc":2.0,"id":"curltext","chain_name":@chain}].to_json
			}
			response = HTTParty.get(@url, options)
			out = response.parsed_response
			result = out[0]['result']
			chain_protocol = result['chain-protocol']
			chain_description = result['chain-description']
			root_stream = result['root-stream-name']
			max_blocksize = result['maximum-block-size']
			default_networkport = result['default-network-port']
			default_rpcport = result['default-rpc-port']
			mining_diversity = result['mining-diversity']
			chain_name = result['chain-name']
			info = {:chain_protocol => chain_protocol, :chain_description => chain_description, :root_stream => root_stream, :max_blocksize => max_blocksize, :default_networkport => default_networkport, :default_rpcport => default_rpcport, :mining_diversity => mining_diversity, :chain_name => chain_name}										#returns chain parameters
			retrieved = JSON.generate info
			return retrieved
		end

		# Function to retrieve node's information on RecordsKeeper Blockchain
		def self.getNodeInfo
			auth = {:username => @user, :password => @password}
			options = {
				:headers => headers= {"Content-Type"=> "application/json","Cache-Control" => "no-cache"},
				:basic_auth => auth,
				:body => [ {"method":"getinfo","params":[],"jsonrpc":2.0,"id":"curltext","chain_name":@chain}].to_json
			}
			response = HTTParty.get(@url, options)
			out = response.parsed_response
			node_balance = out[0]['result']['balance']
			synced_blocks = out[0]['result']['blocks']
			node_address = out[0]['result']['nodeaddress']
			difficulty = out[0]['result']['difficulty']
 			info = {:node_balance => node_balance, :synced_blocks => synced_blocks,:node_address => node_address,:difficulty => difficulty}						# Returns node's details
			retrieved = JSON.generate info
			return retrieved
		end

		# Function to retrieve node's permissions on RecordsKeeper Blockchain
		def self.permissions
			auth = {:username => @user, :password => @password}
			options = {
				:headers => headers= {"Content-Type"=> "application/json","Cache-Control" => "no-cache"},
				:basic_auth => auth,
				:body => [ {"method":"listpermissions","params":[],"jsonrpc":2.0,"id":"curltext","chain_name":@chain}].to_json
			}
			response = HTTParty.get(@url, options)
			out = response.parsed_response
			pms_count_len = out[0]['result']
			pms_count = pms_count_len.length
			permissions = []
			for i in 0...pms_count
				permissions.push(out[0]['result'][i]['type'])
			end
			return permissions;																# Returns list of permissions
		end

		# Function to retrieve pending transactions information on RecordsKeeper Blockchain
		def self.getpendingTransactions
			auth = {:username => @user, :password => @password}
			options = {
				:headers => headers= {"Content-Type"=> "application/json","Cache-Control" => "no-cache"},
				:basic_auth => auth,
				:body => [ {"method":"getmempoolinfo","params":[],"jsonrpc":2.0,"id":"curltext","chain_name":@chain}].to_json
			}
			response = HTTParty.get(@url, options)
			out = response.parsed_response
			tx_count = out[0]['result']['size']											# Stores pending tx count

			if tx_count==0
				tx = "No pending transactions"
			else
				auth = {:username => @user, :password => @password}
				options = {
					:headers => headers= {"Content-Type"=> "application/json","Cache-Control" => "no-cache"},
					:basic_auth => auth,
					:body => [ {"method":"getrawmempool","params":[],"jsonrpc":2.0,"id":"curltext","chain_name":@chain}].to_json
				}
				response2 = HTTParty.get(@url, options)
				out2 = response2.parsed_response
				tx = []
				for i in 0...tx_count
					tx.push(out2[0]['result'])
				end
			end
			pending = {:tx_count => tx_count,:tx => tx}
			pendingtransac = JSON.generate pending														# Returns pending tx and tx count
			return pendingtransac
		end

		# Function to check node's total balance
		def self.checkNodeBalance
			auth = {:username => @user, :password => @password}
			options = {
				:headers => headers= {"Content-Type"=> "application/json","Cache-Control" => "no-cache"},
				:basic_auth => auth,
				:body => [ {"method":"getmultibalances","params":[],"jsonrpc":2.0,"id":"curltext","chain_name":@chain}].to_json
			}
			response = HTTParty.get(@url, options)
			out = response.parsed_response
			balance = out[0]['result']['total'][0]['qty']
			return balance;														# Returns balance of  node
		end
	end

end
