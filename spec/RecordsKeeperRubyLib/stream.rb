# 	Library to work with RecordsKeeper streams.

#   You can publish, retrieve and verify stream data by using stream class.
# 	   You just have to pass parameters to invoke the pre-defined functions.

require 'rubygems'
require 'httparty'
require 'json'
require 'binary_parser'
require 'yaml'
require 'hex_string'

module RecordsKeeperRubyLib

	class Stream

		# # Entry point for accessing Stream class functions
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

	  # Function to publish data into the stream
	  def self.publish address, stream, key, data
	    datahex1 = data.to_hex_string
	    datahex = datahex1.delete(' ')
	    auth = {:username => @user, :password => @password}
		options = {
			:headers => headers= {"Content-Type"=> "application/json","Cache-Control" => "no-cache"},
			:basic_auth => auth,
			:body => [ {"method":"publishfrom","params":[address, stream, key, datahex],"jsonrpc":2.0,"id":"curltext","chain_name":@chain}].to_json
		}
		response = HTTParty.get(@url, options)
		out = response.parsed_response

		txid = out[0]['result']

		if txid.nil?
			txid = out[0]['error']['message']
		end

		return txid;
	   end

	  # Function to retrieve data against transaction id from the stream
	  def self.retrieve stream, txid
	    auth = {:username => @user, :password => @password}
		options = {
			:headers => headers= {"Content-Type"=> "application/json","Cache-Control" => "no-cache"},
			:basic_auth => auth,
			:body => [ {"method":"getstreamitem","params":[stream, txid],"jsonrpc":2.0,"id":"curltext","chain_name":@chain}].to_json
		}
		response = HTTParty.get(@url, options)
		out = response.parsed_response
		check = out[0]['result']

		if check.nil?
			raw_data = out[0]['error']['message']
		else 
			data = out[0]['result']['data']
        	raw_data = data.to_byte_string
       	end
		return raw_data;
	  end

	  # Function to retrieve data against a particular publisher address
	  def self.retrieveWithAddress stream, address, count
	    check = []
	    auth = {:username => @user, :password => @password}
	    options = {
	      :headers => headers= {"Content-Type"=> "application/json","Cache-Control" => "no-cache"},
	      :basic_auth => auth,
	      :body => [ {"method":"liststreampublisheritems","params":[stream, address, false, count],"jsonrpc":2.0,"id":"curltext","chain_name":@chain}].to_json
	    }
	    response = HTTParty.get(@url, options)
	    out = response.parsed_response


	    check = out[0]['result']

	    
	    if check.empty?
	    	retrievedinfo = "No published data found for this address"

	    else
			key = []
		    raw_data = []
		    txid = []
			for i in 0...check.length
				key.push(out[0]['result'][i]['key'])           	  #returns key value of the published data
		        data = out[0]['result'][i]['data']                #returns hex data
		        raw_data.push(data.to_byte_string)    						#returns raw data
		        txid.push(out[0]['result'][i]['txid'])            #returns tx id
			end
			retrieve = {:key => key,:raw_data => raw_data,:txid => txid}
			retrievedinfo = JSON.generate retrieve
		end
		return retrievedinfo
	   end

	  # Function to retrieve data against a particular key value
	  def self.retrieveWithKey stream, key, count
	    auth = {:username => @user, :password => @password}
	    options = {
	      :headers => headers= {"Content-Type"=> "application/json","Cache-Control" => "no-cache"},
	      :basic_auth => auth,
	      :body => [ {"method":"liststreamkeyitems","params":[stream, key, false, count],"jsonrpc":2.0,"id":"curltext","chain_name":@chain}].to_json
	    }
	    response = HTTParty.get(@url, options)
	    out = response.parsed_response
	    
	    check = out[0]['result']

	    if check.nil?
			retrievedinfo = out[0]['error']['message']
		
		else
   
			publisher = []
		    raw_data = []
		    txid = []

			for i in 0...check.length
			  publisher.push(out[0]['result'][i]['publishers'][0])    	#returns publisher's address of published data
		      data = out[0]['result'][i]['data']                        #returns published hex data
		      raw_data.push(data.to_byte_string)           				#returns data published
		      txid.push(out[0]['result'][i]['txid'])                    #returns transaction id of published data
			end
			retrieve = {:publisher => publisher,:raw_data => raw_data,:txid => txid}
			retrievedinfo = JSON.generate retrieve
			return retrievedinfo
		end
	  end	

	  # Function to verify data on RecordsKeeper Blockchain
	  def self.verifyData stream, data, count
	    auth = {:username => @user, :password => @password}
	    options = {
	      :headers => headers= {"Content-Type"=> "application/json","Cache-Control" => "no-cache"},
	      :basic_auth => auth,
	      :body => [ {"method":"liststreamitems","params":[stream,false ,count],"jsonrpc":2.0,"id":"curltext","chain_name":@chain}].to_json
	    }
	    response = HTTParty.get(@url, options)
	    out = response.parsed_response

	    check = out[0]['result']

	    if check.nil?
			result = out[0]['error']['message']
		else 
			raw_data = []
			for i in 0...check.length
				result_data = out[0]['result'][i]['data']						       # returns hex data

		    	if result_data.unicode_normalized?
					raw_data.push(result_data.to_byte_string)	                 # returns raw data
					
				else
		      		raw_data.push("No data found")
		    	end
		    end

		    if raw_data.include?data
				result = "Data is successfully verified."
			else
				result = "Data not found."
		    end
		end
		return result;
	  end

	  # Function to list stream items on RecordsKeeper Blockchain
	  def self.retrieveItems stream, count
	    auth = {:username => @user, :password => @password}
	    options = {
	      :headers => headers= {"Content-Type"=> "application/json","Cache-Control" => "no-cache"},
	      :basic_auth => auth,
	      :body => [ {"method":"liststreamitems","params":[stream, false ,count],"jsonrpc":2.0,"id":"curltext","chain_name":@chain}].to_json
	    }
	    response = HTTParty.get(@url, options)
	    out = response.parsed_response

	    check = out[0]['result']

		if check.nil?
			retrieveditems = out[0]['error']['message']
		else 
			address =[]
			key_value = []
			raw_data = []
			txid = []

			for i in 0...check.length
				address.push(out[0]['result'][i]['publishers'])		        # returns publisher address
				key_value.push(out[0]['result'][i]['key'])			          # returns key value of data
				data = out[0]['result'][i]['data']					              # returns hex data
		        raw_data.push(data.to_byte_string)                     	  # returns raw data
				txid.push(out[0]['result'][i]['txid'])				            # returns tx id
			end
			retrieve = {:address => address,:key_value => key_value,:raw_data => raw_data,:txid => txid}
			retrieveditems = JSON.generate retrieve
		end
		return retrieveditems
	   end
	end

end
