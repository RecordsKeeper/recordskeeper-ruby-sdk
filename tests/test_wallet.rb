require 'test/unit'
require_relative('C:\Users\my pc\Desktop\RK-Ruby-Lib\Lib\wallet.rb')

class WalletTest < Test::Unit::TestCase
  @@cfg = YAML::load(File.open('config.yaml','r'))
  @@net = Wallet.variable

  def test_createwallet
    address = Wallet.createWallet[0]
    addresslength = address.length
    assert_equal addresslength, 34
  end

  def test_getprivkey
    checkprivkey = Wallet.getPrivateKey @@net['miningaddress']
    assert_equal checkprivkey, @@net['privatekey']
  end

  def test_retrievewalletinfo
    wallet_balance = Wallet.retrieveWalletinfo[0]
    assert_operator wallet_balance, :>=, 0
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
