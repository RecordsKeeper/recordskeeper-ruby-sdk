#   Library to work with RecordsKeeper transactions.

#   You can send transaction, create raw transaction, sign raw transaction, send raw transaction, send signed transaction,
#     retrieve transaction information and calculate transaction's fees by using transaction class. You just have to pass
#       parameters to invoke the pre-defined functions.

require 'rubygems'
require 'httparty'
require 'json'
require 'binary_parser'
require 'yaml'
require 'hex_string'

class Transaction

	include HTTParty
	# Entry point for accessing Block class resources.
	# Import values from config file.
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

  # Function to send transaction on RecordsKeeper Blockchain
  def self.sendTransaction sender_address, receiveraddress, data, amount
    data_hex = data.to_hex_string
    datahex = data_hex.delete(' ')
    auth = {:username => @user, :password => @password}
    options = {
      :headers => headers= {"Content-Type"=> "application/json","Cache-Control" => "no-cache"},
      :basic_auth => auth,
      :body => [ {"method":"createrawsendfrom","params":[sender_address, { receiveraddress => amount }, [datahex], "send"],"jsonrpc":2.0,"id":"curltext","chain_name":@chain}].to_json
    }
    response = HTTParty.get(@url, options)
    out = response.parsed_response
    txid = out[0]['result']
    return txid;
  end
  # hello = sendTransaction "mpC8A8Fob9ADZQA7iLrctKtwzyWTx118Q9", "mwp2SHRUaqA7EvfdNFzZkMf1cMZGSh5d1z", "hello", 0.2
  # puts hello

  # Function to create transaction hex on RecordsKeeper Blockchain
	def self.createRawTransaction sender_address, receiveraddress, amount, data
    data_hex = data.to_hex_string
    datahex = data_hex.delete(' ')
    auth = {:username => @user, :password => @password}
    options = {
      :headers => headers= {"Content-Type"=> "application/json","Cache-Control" => "no-cache"},
      :basic_auth => auth,
      :body => [ {"method":"createrawsendfrom","params":[sender_address, {receiveraddress => amount}, [datahex], ''],"jsonrpc":2.0,"id":"curltext","chain_name":@chain}].to_json
    }
    response = HTTParty.get(@url, options)
    out = response.parsed_response
		txhex = out[0]['result']
		return txhex;
  end

  # Function to sign transaction on RecordsKeeper Blockchain
  def self.signRawTransaction txHex, private_key
		priv_key = []
		priv_key.push(private_key)
    auth = {:username => @user, :password => @password}
    options = {
      :headers => headers= {"Content-Type"=> "application/json","Cache-Control" => "no-cache"},
      :basic_auth => auth,
      :body => [ {"method":"signrawtransaction","params":[txHex, [], priv_key],"jsonrpc":2.0,"id":"curltext","chain_name":@chain}].to_json
    }
    response = HTTParty.get(@url, options)
    out = response.parsed_response
		signedHex = out[0]['result']['hex']
		return signedHex;
  end
	# hello = signRawTransaction '010000000156ef0a08ad7aabbb4dc1ac299566892ce99a017e7bf1f0aaabd4e39651d895b20200000000ffffffff03005a6202000000001976a914b2bc8a974aa0b9c4ad82ac0a7017160df0751f5888ac0000000000000000066a0474657374b0305231000000001976a9145f2976565b53d4ed013b6131e98201e89787518688ac00000000', 'cNhDPgqGeU83weydEu5v6opXjeUBkevHLvAupAv9vkAKMs4Z3fdX'
	# puts hello

  # Function to send raw transaction on RecordsKeeper Blockchain
	def self.sendRawTransaction signed_txHex
    auth = {:username => @user, :password => @password}
    options = {
      :headers => headers= {"Content-Type"=> "application/json","Cache-Control" => "no-cache"},
      :basic_auth => auth,
      :body => [ {"method":"sendrawtransaction","params":[signed_txHex],"jsonrpc":2.0,"id":"curltext","chain_name":@chain}].to_json
    }
    response = HTTParty.get(@url, options)
    out = response.parsed_response
		txn = out[0]['result']
		if txn.nil?
			txid = out[0]['error']['message']
		else
			txid = txn
		end
		return txid;
  end
  # hello = sendRawTransaction '0100000001ec0c16bbe0c4e5d88829e0ca003667405fe88e129e3e5f1cc64d06f8c2c22b9e000000006a4730440220616b14a4f7b83390f25d67cca320bb0574f124e392297b103b381b726ebc510a0220487d9056d972ef98f125c534dca6882ca30462b1a7d79be9054d6ddb2365ebdd0121038c1d7be91850add595b238c541d17cfa6e6d780a410bb7db4930a982cad933d4ffffffff0280969800000000001976a9143fca2a2ce8de270fb57fa48289189b243472843288ac10f4de3a000000001976a9145f2976565b53d4ed013b6131e98201e89787518688ac00000000'
  # puts hello

  # Function to send signed transaction on RecordsKeeper Blockchain
  def self.sendSignedTransaction sender_address, receiveraddress, amount, private_key, data
    data_hex = data.to_hex_string
    datahex = data_hex.delete(' ')
    def self.createRawTransaction sender_address, receiveraddress, amount, datahex
      auth = {:username => @user, :password => @password}
      options = {
        :headers => headers= {"Content-Type"=> "application/json","Cache-Control" => "no-cache"},
        :basic_auth => auth,
        :body => [ {"method":"createrawsendfrom","params":[sender_address, {receiveraddress => amount}, [datahex], ""],"jsonrpc":2.0,"id":"curltext","chain_name":@chain}].to_json
      }
      response = HTTParty.get(@url, options)
      out = response.parsed_response
      return out[0]['result']
    end
    txHex = createRawTransaction sender_address, receiveraddress, Float(amount), datahex
    def self.signRawTransaction txHex, private_key
      auth = {:username => @user, :password => @password}
      options = {
        :headers => headers= {"Content-Type"=> "application/json","Cache-Control" => "no-cache"},
        :basic_auth => auth,
        :body => [ {"method":"signrawtransaction","params":[txHex, [], [private_key]],"jsonrpc":2.0,"id":"curltext","chain_name":@chain}].to_json
      }
      response = HTTParty.get(@url, options)
      out = response.parsed_response
      return out[0]['result']['hex']
    end
    signed_tx_hex = signRawTransaction txHex, private_key
    def self.sendRawTransaction signed_tx_hex
      auth = {:username => @user, :password => @password}
      options = {
        :headers => headers= {"Content-Type"=> "application/json","Cache-Control" => "no-cache"},
        :basic_auth => auth,
        :body => [ {"method":"sendrawtransaction","params":[signed_tx_hex],"jsonrpc":2.0,"id":"curltext","chain_name":@chain}].to_json
      }
      response = HTTParty.get(@url, options)
      out = response.parsed_response
      return out[0]['result']
    end
    tx_id = sendRawTransaction signed_tx_hex
    return tx_id;
  end
  # hello = sendSignedTransaction 'mpC8A8Fob9ADZQA7iLrctKtwzyWTx118Q9', 'mwp2SHRUaqA7EvfdNFzZkMf1cMZGSh5d1z', 0.4, 'cNhDPgqGeU83weydEu5v6opXjeUBkevHLvAupAv9vkAKMs4Z3fdX', 'test'
  # puts hello

  # Function to retrieve transaction on RecordsKeeper Blockchain
  def self.retrieveTransaction tx_id
    auth = {:username => @user, :password => @password}
    options = {
      :headers => headers= {"Content-Type"=> "application/json","Cache-Control" => "no-cache"},
      :basic_auth => auth,
      :body => [ {"method":"getrawtransaction","params":[tx_id, 1],"jsonrpc":2.0,"id":"curltext","chain_name":@chain}].to_json
    }
    response = HTTParty.get(@url, options)
    out = response.parsed_response
    sent_hex_data = out[0]['result']['data'][0]
    sent_data = sent_hex_data.to_byte_string
    sent_amount = out[0]['result']['vout'][0]['value']
    return sent_data, sent_amount;					#returns data from retrieved transaction
  end
	# hello = retrieveTransaction "9608f1e6fc503b239f546f5deb1e62d1b596c4d866dc308ae47f78a7dab62c7b"
	# puts hello

  # Function to calculate transaction's fee on RecordsKeeper Blockchain
  def self.getFee address, tx_id
    auth = {:username => @user, :password => @password}
    options = {
      :headers => headers= {"Content-Type"=> "application/json","Cache-Control" => "no-cache"},
      :basic_auth => auth,
      :body => [ {"method":"getaddresstransaction","params":[address, tx_id, true],"jsonrpc":2.0,"id":"curltext","chain_name":@chain}].to_json
    }
    response = HTTParty.get(@url, options)
    out = response.parsed_response
    sent_amount = out[0]['result']['vout'][0]['amount']
    balance_amount = out[0]['result']['balance']['amount']
    fees = balance_amount.abs - sent_amount
    return fees;				#returns fees
  end
	# hello = getFee "mpC8A8Fob9ADZQA7iLrctKtwzyWTx118Q9", "4b1fbf9fb1e5c93cfee2d37ddc5fef444da0a05cc9354a834dc7155ff861a5e0"
	# puts hello

end
