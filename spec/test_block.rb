require 'test/unit'
require_relative ('ruby2/block.rb')

module Ruby2
  class BlockTest < Test::Unit::TestCase
    @@cfg = YAML::load(File.open('config.yaml','r'))
    @@net = Block.variable
    def test_block_info
      miner = Block.blockinfo("100")[2]
      assert_equal miner, @@net['mainaddress']
      size = Block.blockinfo("100")[3]
      assert_equal size, 300
      nonce = Block.blockinfo("100")[4]
      assert_equal nonce, 260863
      merkleroot = Block.blockinfo("100")[8]
      assert_equal merkleroot, @@net['samplemerkleroot']
    end
    def test_retrieveBlocks
      miner = Block.retrieveBlocks("10-20")[1][1]
      assert_equal miner, @@net['mainaddress']
      blocktime = Block.retrieveBlocks("10-20")[2][2]
      assert_equal blocktime,1522831624
      blockhash = Block.retrieveBlocks("10-20")[0][4]
      assert_equal blockhash, @@net['sampleblockhash']
      txcount = Block.retrieveBlocks("10-20")[3][1]
      assert_equal txcount, 1
    end
  end
end
