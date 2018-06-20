require 'test/unit'
require_relative ('RecordsKeeperRuby/blockchain.rb')

module RecordsKeeperRuby
  class BlockchainTest < Test::Unit::TestCase
    @@cfg = YAML::load(File.open('config.yaml','r'))
    @@net = Blockchain.variable

    def test_getchaininfo
      chainname = Blockchain.getChainInfo[7]
      assert_equal chainname, @@net['chain']
      rootstream = Blockchain.getChainInfo[2]
      assert_equal rootstream, "root"
      rpcport = Blockchain.getChainInfo[5]
      assert_equal rpcport, @@net['port']
      networkport = Blockchain.getChainInfo[4]
      assert_equal networkport, 8379
    end

    def test_getnodeinfo
      info = Blockchain.getNodeInfo[1]
      assert_operator info, :>, 60
      balance = Blockchain.getNodeInfo[0]
      assert_not_nil balance
      difficulty = Blockchain.getNodeInfo[3]
      assert_operator difficulty, :<, 1
    end

    def test_permissions
      permissions = Blockchain.permissions
      assert_equal permissions, ['mine', 'admin', 'activate', 'connect', 'send', 'receive', 'issue', 'create']
    end

    def test_getpendingtransactions
      pendingtx = Blockchain.getpendingTransactions[1]
      assert_equal pendingtx, []
      pendingtxcount = Blockchain.getpendingTransactions[0]
      assert_operator pendingtxcount, :>=, 0
    end

    def test_checknodebalance
      balance = Blockchain.checkNodeBalance
      assert_operator balance, :>, 0
    end

  end

end
