#   Library to work with RecordsKeeper Blockchain permissions.

#   You can grant and revoke permissions to any node on Recordskeeper Blockchain by using permissions class.
#   You just have to pass parameters to invoke the pre-defined functions.

require 'rubygems'
require 'httparty'
require 'json'
require 'binary_parser'
require 'yaml'
require 'hex_string'

module RecordsKeeperRubyLib

	class Permissions

		# Entry point for accessing Block class resources.
		if File.exist?('config.yaml')
			# Import values from configuration file.
			cfg = YAML::load(File.open('config.yaml','r'))
			@network = cfg['network']
			@url = cfg['network']['url']
			@user = cfg['network']['rkuser']
			@password = cfg['network']['passwd']
			@chain = cfg['network']['chain']
		else
			#pp ENV
			@network = ENV['network']
			@url = ENV['url']
    		@user = ENV['rkuser']
    		@password = ENV['passwd']
    		@chain = ENV['chain']	
		end


		def self.variable
			net = @network
			return net
		end

	  # Function to grant permissions on RecordsKeeper Blockchain
	  def self.grantPermission address, permissions
	    auth = {:username => @user, :password => @password}
	    options = {
	      :headers => headers= {"Content-Type"=> "application/json","Cache-Control" => "no-cache"},
	      :basic_auth => auth,
	      :body => [ {"method":"grant","params":[address, permissions],"jsonrpc":2.0,"id":"curltext","chain_name":@chain}].to_json
	    }
	    response = HTTParty.get(@url, options)
	    out = response.parsed_response
	    result = out[0]['result']
	    if result.nil?
	      res = out[0]['error']['message']
	    else
	      res = out[0]['result']
	    end
	    return res;									#returns permissions tx id
	  end

	  # Function to revoke permissions on RecordsKeeper Blockchain
	  def self.revokePermission address, permissions
	    auth = {:username => @user, :password => @password}
	    options = {
	      :headers => headers= {"Content-Type"=> "application/json","Cache-Control" => "no-cache"},
	      :basic_auth => auth,
	      :body => [ {"method":"revoke","params":[address, permissions],"jsonrpc":2.0,"id":"curltext","chain_name":@chain}].to_json
	    }
	    response = HTTParty.get(@url, options)
	    out = response.parsed_response
	    result = out[0]['result']
	    if result.nil?
	      res = out[0]['error']['message']
	    else
	      res = out[0]['result']
	    end
	    return res;									#returns revoke permissions tx id
	  end

	end

end
