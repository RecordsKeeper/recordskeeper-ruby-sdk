require 'test/unit'
require 'json'
require_relative ('RecordsKeeperRubyLib/permissions.rb')

module RecordsKeeperRubyLib
  class PermissionsTest < Test::Unit::TestCase
    @@cfg = YAML::load(File.open('config.yaml','r'))
    

    def test_grantpermissions
      txid = Permissions.grantPermission @@cfg['permissionaddress'], "create, connect"
      assert_equal txid, 'Invalid permission'
    end

    def test_revokepermissions
      txid = Permissions.revokePermission @@cfg['permissionaddress'], "send, admin"
      assert_equal txid, 'Invalid permission'
    end

    def test_failgrantpermissions
      txid = Permissions.grantPermission @@cfg['permissionaddress'], "create, connect"
      assert_equal txid, @@cfg['sampletxid']
    end

    def test_failrevokepermissions
      txid = Permissions.revokePermission @@cfg['permissionaddress'], "create, connect"
      assert_equal txid, @@cfg['sampletxid']
    end

  end

end
