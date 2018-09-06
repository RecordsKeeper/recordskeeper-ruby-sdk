require 'test/unit'
require 'json'
require_relative ('RecordsKeeperRubyLib/block.rb')

module RecordsKeeperRubyLib
  class BlockTest < Test::Unit::TestCase
    @@cfg = YAML::load(File.open('config.yaml','r'))
    
    def test_block_info
      miner = JSON.parse Block.blockinfo 100
      assert_equal miner['miner'], @@cfg['mainaddress']
      size = JSON.parse Block.blockinfo 100
      assert_equal size['size'], 300
      nonce = JSON.parse Block.blockinfo 100
      assert_equal nonce['nonce'], 260863
      merkleroot = JSON.parse Block.blockinfo 100
      assert_equal merkleroot['merkleroot'], @@cfg['samplemerkleroot']
    end
    def test_retrieveBlocks
      miner = JSON.parse Block.retrieveBlocks "10-20"
      assert_equal miner['miner'][1], @@cfg['mainaddress']
      blocktime = JSON.parse Block.retrieveBlocks "10-20"
      assert_equal blocktime['blocktime'][2],1522831624
      blockhash = JSON.parse Block.retrieveBlocks "10-20"
      assert_equal blockhash['blockhash'][4], @@cfg['sampleblockhash']
      txcount = JSON.parse Block.retrieveBlocks "10-20"
      assert_equal txcount['tx_count'][1], 1
    end
  end
end
