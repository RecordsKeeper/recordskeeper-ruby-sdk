require 'test/unit'
require 'json'
require_relative ('RecordsKeeperRubyLib/transaction.rb')

module RecordsKeeperRubyLib
  class TransactionTest < Test::Unit::TestCase
    @@cfg = YAML::load(File.open('config.yaml','r'))

    def test_sendtransaction
      txid = Transaction.sendTransaction @@cfg['miningaddress'], @@cfg['validaddress'], "hello", 0.2
      tx_size = txid.length
      assert_equal tx_size, 64
    end

    def test_sendrawtransaction
      txid = Transaction.sendRawTransaction @@cfg['dumpsignedtxhex']
      tx_size = txid.length
      assert_equal tx_size, 34
    end

    def test_signrawtransaction
    	txhex = Transaction.signRawTransaction @@cfg['dumptxhex'], @@cfg['privatekey']
      tx_size = txhex.length
    	assert_equal tx_size, 268
    end

    def test_createrawtransaction
    	txhex = Transaction.createRawTransaction @@cfg['miningaddress'], @@cfg['validaddress'], @@cfg['testdata'], @@cfg['amount']
      tx_size = txhex.length
    	assert_equal tx_size, 268
    end

    def test_sendsignedtransaction
    	txid = Transaction.sendSignedTransaction @@cfg['miningaddress'], @@cfg['validaddress'] ,@@cfg['testdata'], @@cfg['amount'], @@cfg['privatekey']
      tx_size = txid.length
    	assert_equal tx_size, 64
    end

    def test_retrievetransaction
    	data = JSON.parse Transaction.retrieveTransaction @@cfg['dumptxid']
      sentdata = data['sent_data']
    	assert_equal sentdata, "hellodata"
      sentamount = data['sent_amount']
      assert_operator sentamount, :>=, 0
    end

    def test_getfee
    	fees = Transaction.getFee @@cfg['miningaddress'], @@cfg['transactionid']
    	assert_equal fees, 0.0269
    end

  end
end
