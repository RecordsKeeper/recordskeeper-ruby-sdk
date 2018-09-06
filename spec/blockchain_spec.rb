require 'test/unit'
require 'json'
require_relative ('RecordsKeeperRubyLib/blockchain.rb')

module RecordsKeeperRubyLib
  class BlockchainTest < Test::Unit::TestCase
    @@cfg = YAML::load(File.open('config.yaml','r'))

    def test_getchaininfo
      chainname = JSON.parse Blockchain.getChainInfo
      assert_equal chainname['chain_name'], @@cfg['chain']
      rootstream = JSON.parse Blockchain.getChainInfo
      assert_equal rootstream['root_stream'], "root"
      rpcport = JSON.parse Blockchain.getChainInfo
      assert_equal rpcport['default_rpcport'], @@cfg['port']
      networkport = JSON.parse Blockchain.getChainInfo
      assert_equal networkport['default_networkport'], 8379
    end

    def test_getnodeinfo
      info = JSON.parse Blockchain.getNodeInfo
      assert_operator info['synced_blocks'], :>, 60
      balance = JSON.parse Blockchain.getNodeInfo
      assert_not_nil balance['node_balance']
      difficulty = JSON.parse Blockchain.getNodeInfo
      assert_operator difficulty['difficulty'], :<, 1
    end

    def test_permissions
      permissions = Blockchain.permissions
      assert_equal permissions, ['mine', 'admin', 'activate', 'connect', 'send', 'receive', 'issue', 'create']
    end

    def test_getpendingtransactions
      pendingtxcount = JSON.parse Blockchain.getpendingTransactions
      assert_equal pendingtxcount['tx_count'], 0
      pendingtx = JSON.parse Blockchain.getpendingTransactions
      assert_equal pendingtx['tx'], "No pending transactions"
    end

    def test_checknodebalance
      balance = Blockchain.checkNodeBalance
      assert_operator balance, :>, 0
    end

  end

end
