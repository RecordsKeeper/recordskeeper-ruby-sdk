require 'test/unit'
require 'json'
require_relative ('RecordsKeeperRubyLib/address.rb')

module RecordsKeeperRubyLib
  class AddressTest < Test::Unit::TestCase
    @@cfg = YAML::load(File.open('config.yaml','r'))
    
    def test_getaddress
      address = Address.getAddress
      address_size = address.length
      assert_equal address_size, 34
    end
    def test_getmultisigaddress
      address = Address.getMultisigAddress 2,  @@cfg['samplegetmultisigaddress']
      assert_equal address, @@cfg['multisigaddress']
    end

    def test_checkifvalid
      checkaddress = Address.checkifValid @@cfg['validaddress']
      assert_equal checkaddress, 'Address is valid'
    end

    def test_failcheckifvalid
      wrongaddress = Address.checkifValid @@cfg['invalidaddress']
      assert_equal wrongaddress, 'Address is valid'
    end

    def test_checkifmineallowed
      checkaddress = Address.checkifMineAllowed @@cfg['miningaddress']
      assert_equal checkaddress, 'Address has mining permission'
    end

    def test_failcheckifmineallowed
      wrongaddress = Address.checkifMineAllowed @@cfg['nonminingaddress']
      assert_equal wrongaddress, 'Address mining permission'
    end
    def test_checkbalance
      balance = Address.checkBalance @@cfg['nonminingaddress']
      assert_equal balance, 5
    end
    def test_getmultisigwalletaddress
      address = Address.getMultisigWalletAddress 2, @@cfg['samplegetmultisigaddress']
      assert_equal address, @@cfg['multisigaddress']
    end
    def test_importaddress
      address = Address.importAddress @@cfg['miningaddress']
      assert_equal address, "Address successfully imported"
    end
    def test_wrongimportaddress
      address = Address.importAddress @@cfg['wrongimportaddress']
      assert_equal address, "Invalid Rk address or script"
    end

  end
end
