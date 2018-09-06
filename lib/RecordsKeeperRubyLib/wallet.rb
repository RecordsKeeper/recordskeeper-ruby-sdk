#   Library to work with RecordsKeeper wallet.

#   You can create wallet, create multisignature wallet, retrieve wallet's information, retrieve private key of a particular
#     wallet address, sign message verify message, dump wallet file, backup wallet file, import wallet file, encrypt wallet by
#       using wallet class. You just have to pass parameters to invoke the pre-defined functions.

require 'rubygems'
require 'httparty'
require 'json'
require 'binary_parser'
require 'yaml'
require 'hex_string'

module RecordsKeeperRubyLib
	class Wallet
		
		# # Entry point for accessing Wallet class functions
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

	  # Function to create wallet on RecordsKeeper Blockchain
		def self.createWallet
		    auth = {:username => @user, :password => @password}
		    options = {
		      :headers => headers= {"Content-Type"=> "application/json","Cache-Control" => "no-cache"},
		      :basic_auth => auth,
		      :body => [ {"method":"createkeypairs","params":[],"jsonrpc":2.0,"id":"curltext","chain_name":@chain}].to_json
		    }
		    response = HTTParty.get(@url, options)
		    out = response.parsed_response
			public_address = out[0]['result'][0]['address']			# returns public address of the wallet
			private_key = out[0]['result'][0]['privkey']				# returns private key of the wallet
			public_key = out[0]['result'][0]['pubkey']					# returns public key of the wallet

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
			  return result;
		    end
			import_address = importAddress public_address
			retrieve = {:public_address => public_address,:private_key => private_key,:public_key => public_key}
			retrievedinfo = JSON.generate retrieve
			return retrievedinfo
	    end

		# Function to retrieve private key of a wallet address on RecordsKeeper Blockchain
	   def self.getPrivateKey public_address
		    auth = {:username => @user, :password => @password}
		    options = {
		      :headers => headers= {"Content-Type"=> "application/json","Cache-Control" => "no-cache"},
		      :basic_auth => auth,
		      :body => [ {"method":"dumpprivkey","params":[public_address],"jsonrpc":2.0,"id":"curltext","chain_name":@chain}].to_json
		    }
		    response = HTTParty.get(@url, options)
		    out = response.parsed_response
			result = out[0]['result']
			if result.nil?
				private_key = out[0]['error']['message']
			else
				private_key = out[0]['result']
	    	end
			return private_key;							#returns private key
	   end

		# Function to retrieve wallet's information on RecordsKeeper Blockchain
      def self.retrieveWalletinfo
	    auth = {:username => @user, :password => @password}
	    options = {
	      :headers => headers= {"Content-Type"=> "application/json","Cache-Control" => "no-cache"},
	      :basic_auth => auth,
	      :body => [ {"method":"getwalletinfo","params":[],"jsonrpc":2.0,"id":"curltext","chain_name":@chain}].to_json
	    }
	    response = HTTParty.get(@url, options)
	    out = response.parsed_response
		balance = out[0]['result']['balance']
		tx_count = out[0]['result']['txcount']
		unspent_tx = out[0]['result']['utxocount']
		retrieve = {:balance => balance,:tx_count => tx_count,:unspent_tx => unspent_tx}
		retrievedinfo = JSON.generate retrieve
		return retrievedinfo
	  end

		# Function to create wallet's backup on RecordsKeeper Blockchain
		def self.backupWallet filename
	    auth = {:username => @user, :password => @password}
	    options = {
	      :headers => headers= {"Content-Type"=> "application/json","Cache-Control" => "no-cache"},
	      :basic_auth => auth,
	      :body => [ {"method":"backupwallet","params":[filename],"jsonrpc":2.0,"id":"curltext","chain_name":@chain}].to_json
	    }
	    response = HTTParty.get(@url, options)
	    out = response.parsed_response
		result = out[0]['result']
		if result.nil?
			res = "Backup successful!"
		else
			res = out[0]['error']['message']
	    end
			return res;								#returns result
	  end

		# Function to import wallet's backup on RecordsKeeper Blockchain
	  def self.importWallet filename
	    auth = {:username => @user, :password => @password}
	    options = {
	      :headers => headers= {"Content-Type"=> "application/json","Cache-Control" => "no-cache"},
	      :basic_auth => auth,
	      :body => [ {"method":"importwallet","params":[filename],"jsonrpc":2.0,"id":"curltext","chain_name":@chain}].to_json
	    }
	    response = HTTParty.get(@url, options)
	    out = response.parsed_response
		result = out[0]['result']
		if result.nil?
			res = "Wallet is successfully imported"
		else
			res = out[0]['error']['message']
	    end
			return res;								#returns result
	  end

		# Function to dump wallet on RecordsKeeper Blockchain
	  def self.dumpWallet filename
	    auth = {:username => @user, :password => @password}
	    options = {
	      :headers => headers= {"Content-Type"=> "application/json","Cache-Control" => "no-cache"},
	      :basic_auth => auth,
	      :body => [ {"method":"dumpwallet","params":[filename],"jsonrpc":2.0,"id":"curltext","chain_name":@chain}].to_json
	    }
	    response = HTTParty.get(@url, options)
	    out = response.parsed_response
		result = out[0]['result']
		if result.nil?
			res = "Wallet is successfully dumped"
		else
			res = out[0]['error']['message']
	    end
			return res;								#returns result
	  end

		# Function to lock wallet on RecordsKeeper Blockchain
	  def self.lockWallet password
	    auth = {:username => @user, :password => @password}
	    options = {
	      :headers => headers= {"Content-Type"=> "application/json","Cache-Control" => "no-cache"},
	      :basic_auth => auth,
	      :body => [ {"method":"encryptwallet","params":[password],"jsonrpc":2.0,"id":"curltext","chain_name":@chain}].to_json
	    }
	    response = HTTParty.get(@url, options)
	    out = response.parsed_response
		result = out[0]['result']
		if result.nil?
			res = "Wallet is successfully encrypted."
		else
			res = out[0]['error']['message']
	    end
			return res;								#returns result
	  end

		# Function to unlock wallet on RecordsKeeper Blockchain
		def self.unlockWallet password, unlocktime
	    auth = {:username => @user, :password => @password}
	    options = {
	      :headers => headers= {"Content-Type"=> "application/json","Cache-Control" => "no-cache"},
	      :basic_auth => auth,
	      :body => [ {"method":"walletpassphrase","params":[password, unlocktime],"jsonrpc":2.0,"id":"curltext","chain_name":@chain}].to_json
	    }
	    response = HTTParty.get(@url, options)
	    out = response.parsed_response
		result = out[0]['result']
		if result.nil?
			res = "Wallet is successfully unlocked."
		else
			res = out[0]['error']['message']
	    end
			return res;								#returns result
	  end

		# Function to change password for wallet on RecordsKeeper Blockchain
	  def self.changeWalletPassword old_password, new_password
	    auth = {:username => @user, :password => @password}
	    options = {
	      :headers => headers= {"Content-Type"=> "application/json","Cache-Control" => "no-cache"},
	      :basic_auth => auth,
	      :body => [ {"method":"walletpassphrasechange","params":[old_password, new_password],"jsonrpc":2.0,"id":"curltext","chain_name":@chain}].to_json
	    }
	    response = HTTParty.get(@url, options)
	    out = response.parsed_response
		result = out[0]['result']
		if result.nil?
			res = "Password successfully changed!"
		else
			res = out[0]['error']['message']
	    end
		return res;								#returns result
	  end

		# Function to sign message on RecordsKeeper Blockchain
	  def self.signMessage private_key, message
	    auth = {:username => @user, :password => @password}
	    options = {
	      :headers => headers= {"Content-Type"=> "application/json","Cache-Control" => "no-cache"},
	      :basic_auth => auth,
	      :body => [ {"method":"signmessage","params":[private_key, message],"jsonrpc":2.0,"id":"curltext","chain_name":@chain}].to_json
	    }
	    response = HTTParty.get(@url, options)
	    out = response.parsed_response
	    check = out[0]['result']

		if check.nil?
			signedMessage = out[0]['error']['message']
		else 
			signedMessage = out[0]['result']
		end
		return signedMessage;									#returns private key
	  end

		# Function to verify message on RecordsKeeper Blockchain
	  def self.verifyMessage address, signedMessage, message
	    auth = {:username => @user, :password => @password}
	    options = {
	      :headers => headers= {"Content-Type"=> "application/json","Cache-Control" => "no-cache"},
	      :basic_auth => auth,
	      :body => [ {"method":"verifymessage","params":[address, signedMessage, message],"jsonrpc":2.0,"id":"curltext","chain_name":@chain}].to_json
	    }
	    response = HTTParty.get(@url, options)
	    out = response.parsed_response
		verifiedMessage = out[0]['result']
		error = out[0]['error']
		if verifiedMessage
			validity = "Yes, message is verified"
		elsif error.nil?
			validity = "No, signedMessage is not correct"
		else 
			validity = error['message']
        end
		return validity;										#returns validity
	  end
	end

end

