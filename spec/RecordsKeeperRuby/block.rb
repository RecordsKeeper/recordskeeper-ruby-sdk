# Library to work with RecordsKeeper blocks.

#   You can retrieve complete block information by using block class.
#   You just have to pass parameters to invoke the pre-defined functions.

# Import the following libraries

require 'rubygems'
require 'httparty'
require 'json'
require 'binary_parser'
require 'yaml'

module RecordsKeeperRuby
	class Block

		#Entry point for accessing Block class resources.
		#Import values from config file.
		cfg = YAML::load(File.open('config.yaml','r'))
		@network = cfg['testnet']								# Network variable to store the networrk that you want to access
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

		def self.blockinfo block_height
			auth = {:username => @user, :password => @password}
			options = {
				:headers => headers= {"Content-Type"=> "application/json","Cache-Control" => "no-cache"},
				:basic_auth => auth,
				:body => [ {"method":"getblock","params":[block_height],"jsonrpc":2.0,"id":"curltext","chain_name":@chain}].to_json
			}
			response = HTTParty.get(@url, options)
			out = response.parsed_response
			tx_count_number = out[0]['result']['tx']
			tx_count = tx_count_number.length														# variable returns block's transaction count
			miner = out[0]['result']['miner']														# variable returns block's miner
			size = out[0]['result']['size']															# variable returns block's size
			nonce = out[0]['result']['nonce']														# variable returns block's nonce
			blockHash = out[0]['result']['hash']												# variable returns blockhash
			prevblock = out[0]['result']['previousblockhash']						# variable returns prevblockhash
			nextblock = out[0]['result']['nextblockhash']								# variable returns nextblockhash
			merkleroot = out[0]['result']['merkleroot']									# variable returns merkleroot
			blocktime = out[0]['result']['time']												# variable returns blocktime
			difficulty = out[0]['result']['difficulty']									# variable returns difficulty
			tx = []																											# list to store transaction ids
			for i in 0...tx_count
				tx.push(out[0]['result']['tx'][i])										# pushes transaction ids onto tx list
			end
			return  tx_count, tx, miner, size, nonce, blockHash, prevblock, nextblock, merkleroot, blocktime, difficulty;
		end

		def self.retrieveBlocks block_range
			blockhash = []
			miner = []
			blocktime = []
			tx_count = []
			auth = {:username => @user, :password => @password}
			options = {
				:headers => headers= {"Content-Type"=> "application/json","Cache-Control" => "no-cache"},
				:basic_auth => auth,
				:body => [ {"method":"listblocks","params":[block_range],"jsonrpc":2.0,"id":"curltext","chain_name":@chain}].to_json
			}
			response = HTTParty.get(@url, options)
			out = response.parsed_response
			block_count_len = out[0]['result']
			block_count = block_count_len.length
			for i in 0...block_count
				blockhash.push(out[0]['result'][i]['hash'])
				miner.push(out[0]['result'][i]['miner'])
				blocktime.push(out[0]['result'][i]['time'])
				tx_count.push(out[0]['result'][i]['txcount'])
			end
			return blockhash, miner, blocktime, tx_count;
		end
	end
end
