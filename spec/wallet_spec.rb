require 'test/unit'
require 'json'
require_relative ('RecordsKeeperRubyLib/wallet.rb')

module RecordsKeeperRubyLib
  class WalletTest < Test::Unit::TestCase
    @@cfg = YAML::load(File.open('config.yaml','r'))

    def test_createwallet
      address = JSON.parse Wallet.createWallet
      addresslength = address['public_address'].length
      assert_equal addresslength, 38
    end

    def test_getprivkey
      checkprivkey = Wallet.getPrivateKey @@cfg['miningaddress']
      assert_equal checkprivkey, @@cfg['privatekey']
    end

    def test_retrievewalletinfo
      wallet_balance = JSON.parse Wallet.retrieveWalletinfo
      assert_operator wallet_balance['balance'], :>=, 0
    end

    def test_signmessage
      signedMessage = Wallet.signMessage @@cfg['miningaddress'], @@cfg['testdata']
      assert_equal signedMessage, @@cfg['signedtestdata']
    end

    def test_verifymessage
      validity = Wallet.verifyMessage @@cfg['miningaddress'], @@cfg['signedtestdata'], @@cfg['testdata']
      assert_equal validity, "Yes, message is verified"
    end

  end
end
