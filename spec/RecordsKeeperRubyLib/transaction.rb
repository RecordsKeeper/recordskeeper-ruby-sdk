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

module RecordsKeeperRubyLib

	class Transaction

		# # Entry point for accessing Transaction class functions
		if File.exist?('config.yaml')
			# Import values from configuration file.
			cfg = YAML::load(File.open('config.yaml','r'))
			
			@url = cfg['url']
			@user = cfg['rkuser']
			@password = cfg['passwd']
			@chain = cfg['chain']
		
		else
			#Import using ENV variables
			
			@url = ENV['url']
    		@user = ENV['rkuser']
    		@password = ENV['passwd']
    		@chain = ENV['chain']	
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
	    check = out[0]['result']

		if check.nil?
			txid = out[0]['error']['message']
		else 
	    	txid = out[0]['result']
	    end
	    return txid;
	  end

	  # Function to create transaction hex on RecordsKeeper Blockchain
	  def self.createRawTransaction sender_address, receiveraddress, data, amount
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
	    check = out[0]['result']

		if check.nil?
			txhex = out[0]['error']['message']
		else 
			txhex = out[0]['result']
		end
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
		if out[0]['result']['complete']
			signedHex = out[0]['result']['hex']
		else
			signedHex = "Transaction has not been signed properly."
		end
			return signedHex;
	  end

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

	  # Function to send signed transaction on RecordsKeeper Blockchain
	  def self.sendSignedTransaction sender_address, receiveraddress, data, amount, private_key
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
	    check = out[0]['result']

		if check.nil?
			retrievedinfo = out[0]['error']['message']
		else 
		    sent_hex_data = out[0]['result']['data'][0]
		    sent_data = sent_hex_data.to_byte_string
		    sent_amount = out[0]['result']['vout'][0]['value']
			retrieve = {:sent_data => sent_data,:sent_amount => sent_amount }
			retrievedinfo = JSON.generate retrieve
		end
		return retrievedinfo
	  end

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
	    check = out[0]['result']

		if check.nil?
			fees = out[0]['error']['message']
		else 
		    sent_amount = out[0]['result']['vout'][0]['amount']
		    balance_amount = out[0]['result']['balance']['amount']
		    fees = balance_amount.abs - sent_amount
		end
	    return fees;				#returns fees
	 end
	  

	end

end
