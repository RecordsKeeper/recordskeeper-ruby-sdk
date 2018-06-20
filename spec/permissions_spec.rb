require 'test/unit'
require_relative ('RecordsKeeperRuby/permissions.rb')

module RecordsKeeperRuby
  class PermissionsTest < Test::Unit::TestCase
    @@cfg = YAML::load(File.open('config.yaml','r'))
    @@net = Permissions.variable

    def test_grantpermissions
      txid = Permissions.grantPermission @@net['permissionaddress'], "create, connect"
      assert_equal txid, 'Invalid permission'
    end

    def test_revokepermissions
      txid = Permissions.revokePermission @@net['permissionaddress'], "send, admin"
      assert_equal txid, 'Invalid permission'
    end

    def test_failgrantpermissions
      txid = Permissions.grantPermission @@net['permissionaddress'], "create, connect"
      assert_equal txid, @@net['sampletxid']
    end

    def test_failrevokepermissions
      txid = Permissions.revokePermission @@net['permissionaddress'], "create, connect"
      assert_equal txid, @@net['sampletxid']
    end

  end

end
