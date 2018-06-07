require 'test/unit'
require_relative('C:\Users\my pc\Desktop\RK-Ruby-Lib\Lib\stream.rb')

class StreamTest < Test::Unit::TestCase
  @@cfg = YAML::load(File.open('config.yaml','r'))
  @@net = Stream.variable

  def test_publish
    txid = Stream.publish @@net['miningaddress'], @@net['stream'], @@net['testdata'], "This is test data"
    tx_size = txid.length
    assert_equal tx_size, 64
  end

  def test_retrieve_with_txid
    result = Stream.retrieve @@net['stream'], @@net['sampletransac']
    assert_equal result,"testdata"
  end

  def test_retrieve_with_id_address
    result = Stream.retrieveWithAddress @@net['stream'], @@net['miningaddress'], 5
    assert_equal result[1][1], @@net['sampledata']
  end

  def test_retrieve_with_key
    result = Stream.retrieveWithKey @@net['stream'], @@net['testdata'], 5
    assert_equal result[1][1], @@net['sampledata']
  end

  def test_verifyData
    result = Stream.verifyData @@net['stream'], @@net['testdata'], 5
    assert_equal result, "Data not found."
  end

  def test_retrieveItems
    result1 = Stream.retrieveItems @@net['stream'], 5
    result = result1[2][2]
    assert_equal result, "This is test data"
  end

end
