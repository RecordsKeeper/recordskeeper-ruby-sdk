require 'test/unit'
require 'json'
require_relative ('RecordsKeeperRubyLib/stream.rb')

module RecordsKeeperRubyLib
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
      result = JSON.parse Stream.retrieveWithAddress @@net['stream'], @@net['miningaddress'], 5
      assert_equal result['raw_data'][1], @@net['sampledata']
    end

    def test_retrieve_with_key
      result = JSON.parse Stream.retrieveWithKey @@net['stream'], @@net['testdata'], 5
      assert_equal result['raw_data'][1], @@net['sampledata']
    end

    def test_verifyData
      result = Stream.verifyData @@net['stream'], @@net['testdata'], 5
      assert_equal result, "Data not found."
    end

    def test_retrieveItems
      result1 = JSON.parse Stream.retrieveItems @@net['stream'], 5
      assert_equal result1['raw_data'][2], "This is test data"
    end

  end
end
