 RecordsKeeper-Ruby-SDK
 =========================

It is an infrastructure to build RecordsKeeper blockchain-based applications, products and is used to work around applications that are built on top of this blockchain platform.

**Note:** If you're looking for the RecordsKeeper Ruby Library please see: [RecordsKeeper Ruby Library](https://github.com/RecordsKeeper/recordskeeper-ruby-sdk)


## Getting Started

Before you begin you need to setup Ruby Development Environment.  


Import these ruby libraries first to get started with the library classes and functions.


```bash
require 'rubygems'
require 'httparty'
require 'json'
require 'binary_parser'
require 'yaml'
require 'hex_string'
```


Creating Connection
-------------------

Entry point for accessing Address class resources.

Make Config file to import config parameters.
   
Import chain url and chain name from config file:

* URL: Url to connect to the chain ([RPC Host]:[RPC Port])
* Chain-name: chain name

```bash

    url = network['url']
    chain-name = network['chain']

``` 

Node Authentication
-------------------

Import user name and password values from config file to authenticate the node:

* User name: The rpc user is used to call the APIs.
* Password: The rpc password is used to authenticate the APIs.

```bash
    
    user = network['rkuser']
    password = network['passwd']

``` 

## Libraries

- [Address](https://github.com/RecordsKeeper/recordskeeper-ruby-sdk/blob/master/lib/RecordsKeeperRubyLib/address.rb) Library to work with RecordsKeeper addresses. You can generate new address, check all addresses, check address validity, check address permissions, check address balance by using Address class. You just have to pass parameters to invoke the pre-defined functions.

- [Assets](https://github.com/RecordsKeeper/recordskeeper-ruby-sdk/blob/master/lib/RecordsKeeperRubyLib/assets.rb) Library to work with RecordsKeeper assets. You can create new assets and list all assets by using Assets class. You just have to pass parameters to invoke the pre-defined functions.

- [Block](https://github.com/RecordsKeeper/recordskeeper-ruby-sdk/blob/master/lib/RecordsKeeperRubyLib/block.rb) Library to work with RecordsKeeper block informaion. You can collect block information by using block class. You just have to pass parameters to invoke the pre-defined functions.

- [Blockchain](https://github.com/RecordsKeeper/recordskeeper-ruby-sdk/blob/master/lib/RecordsKeeperRubyLib/blockchain.rb) Library to work with RecordsKeeper block informaion. You can collect block information by using block class. You just have to pass parameters to invoke the pre-defined functions.

- [Permissions](https://github.com/RecordsKeeper/recordskeeper-ruby-sdk/blob/master/lib/RecordsKeeperRubyLib/permissions.rb) Library to work with RecordsKeeper permissions. You can grant and revoke permissions like connect, send, receive, create, issue, mine, activate, admin by using Assets class. You just have to pass parameters to invoke the pre-defined functions.

- [Stream](https://github.com/RecordsKeeper/recordskeeper-ruby-sdk/blob/master/lib/RecordsKeeperRubyLib/stream.rb) Library to work with RecordsKeeper streams. You can publish, retrieve and verify stream data by using stream class. You just have to pass parameters to invoke the pre-defined functions.

- [Transaction](https://github.com/RecordsKeeper/recordskeeper-ruby-sdk/blob/master/lib/RecordsKeeperRubyLib/transaction.rb) Library to work with RecordsKeeper transactions. You can send transaction, create raw transaction, sign raw transaction, send raw transaction, send signed transaction, retrieve transaction information and calculate transaction's fees by using transaction class. You just have to pass parameters to invoke the pre-defined functions.

- [Wallet](https://github.com/RecordsKeeper/recordskeeper-ruby-sdk/blob/master/lib/RecordsKeeperRubyLib/wallet.rb) Library to work with RecordsKeeper wallet functionalities. You can create wallet, dump wallet into a file, backup wallet into a file, import wallet from a file, lock wallet, unlock wallet, change wallet's password, retrieve private key, retrieve wallet's information, sign and verify message by using wallet class. You just have to pass parameters to invoke the pre-defined functions.


## Unit Tests

Under recordskeeper_ruby_ spec/test using test data from config.yaml file.
- Command to run a all the tests: 
rake spec 
- Command to a specific test file:
rspec spec/[test_name.rb]


## Documentation

The complete documentation is here: [RecordsKeeper Ruby Library Documentation](https://github.com/RecordsKeeper/recordskeeper-ruby-sdk/tree/master/docs).

