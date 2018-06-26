require 'test/unit'
require 'json'
require_relative ('RecordsKeeperRubyLib/wallet.rb')

module RecordsKeeperRubyLib
  class WalletTest < Test::Unit::TestCase
    @@cfg = YAML::load(File.open('config.yaml','r'))
    @@net = Wallet.variable

    def test_createwallet
      address = JSON.parse Wallet.createWallet
      addresslength = address['public_address'].length
      assert_equal addresslength, 38
    end

    def test_getprivkey
      checkprivkey = Wallet.getPrivateKey @@net['miningaddress']
      assert_equal checkprivkey, @@net['privatekey']
    end

    def test_retrievewalletinfo
      wallet_balance = JSON.parse Wallet.retrieveWalletinfo
      assert_operator wallet_balance['balance'], :>=, 0
    end

    def test_signmessage
      signedMessage = Wallet.signMessage @@net['miningaddress'], @@net['testdata']
      assert_equal signedMessage, @@net['signedtestdata']
    end

    def test_verifymessage
      validity = Wallet.verifyMessage @@net['miningaddress'], @@net['signedtestdata'], @@net['testdata']
      assert_equal validity, "Yes, message is verified"
    end

  end
end
