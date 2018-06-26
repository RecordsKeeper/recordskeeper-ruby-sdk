require 'test/unit'
require 'json'
require_relative ('RecordsKeeperRubyLib/assets.rb')

module RecordsKeeperRubyLib
  class AssetsTest < Test::Unit::TestCase
    @@cfg = YAML::load(File.open('config.yaml','r'))
    @@net = Assets.variable

    def test_createasset
      txid = Assets.createAsset @@net['validaddress'], "xyz", 100
      assert_equal txid, "Asset or stream with this name already exists"
    end

    def test_retrieveassets
      name = Assets.retrieveAssets[0]
      assert_equal name, []
    end

    def test_retrieveassets
      txid = Assets.retrieveAssets[1]
      assert_equal txid, []
    end

    def test_retrieveassets
      qty = Assets.retrieveAssets[2]
      assert_equal qty, []
    end

  end

end
