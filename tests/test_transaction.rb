require 'test/unit'
require_relative('C:\Users\my pc\Desktop\RK-Ruby-Lib\Lib\transaction.rb')

class TransactionTest < Test::Unit::TestCase
  @@cfg = YAML::load(File.open('config.yaml','r'))
  @@net = Transaction.variable

  def test_sendtransaction
    txid = Transaction.sendTransaction @@net['miningaddress'], @@net['validaddress'], "hello", 0.2
    tx_size = txid.length
    assert_equal tx_size, 64
  end

  def test_sendrawtransaction
    txid = Transaction.sendRawTransaction @@net['dumpsignedtxhex']
    tx_size = txid.length
    assert_equal tx_size, 34
  end

  def test_signrawtransaction
  	txhex = Transaction.signRawTransaction @@net['dumptxhex'], @@net['privatekey']
    tx_size = txhex.length
  	assert_equal tx_size, 268
  end

  def test_createrawtransaction
  	txhex = Transaction.createRawTransaction @@net['miningaddress'], @@net['validaddress'], @@net['amount'], @@net['testdata']
    tx_size = txhex.length
  	assert_equal tx_size, 268
  end

  def test_sendsignedtransaction
  	txid = Transaction.sendSignedTransaction @@net['miningaddress'], @@net['validaddress'] , @@net['amount'], @@net['privatekey'],@@net['testdata']
    tx_size = txid.length
  	assert_equal tx_size, 64
  end

  def test_retrievetransaction

  	data = Transaction.retrieveTransaction @@net['dumptxid']
    sentdata = data[0]
  	assert_equal sentdata, "hellodata"
    sentamount = data[1]
    assert_operator sentamount, :>=, 0
  end

  def test_getfee
  	fees = Transaction.getFee @@net['miningaddress'], @@net['transactionid']
  	assert_equal fees, 0.0269
  end

end
