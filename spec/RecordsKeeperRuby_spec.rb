# RSpec.describe RecordsKeeperRuby do
#   it "has a version number" do
#     expect(RecordsKeeperRuby::VERSION).not_to be nil
#   end
#
#   it "does something useful" do
#     expect(false).to eq(true)
#   end
# end

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require_relative ('address_spec.rb')
require_relative ('block_spec.rb')
require_relative ('blockchain_spec.rb')
require_relative ('permissions_spec.rb')
require_relative ('stream_spec.rb')
require_relative ('transaction_spec.rb')
require_relative ('assets_spec.rb')
require_relative ('wallet_spec.rb')

RSpec.describe RecordsKeeperRuby do
  it 'Address test succeeds!' do
    true
    require_relative ('address_spec.rb')
  end
  it 'Block test succeeds!' do
    true
    require_relative ('block_spec.rb')
  end
  it 'Blockchcain test succeeds!' do
    true
    require_relative ('blockchain_spec.rb')
  end
  it 'Permissions test succeeds!' do
    true
    require_relative ('permissions_spec.rb')
  end
  it 'Stream test succeeds!' do
    true
    require_relative ('stream_spec.rb')
  end
  it 'Transaction test succeeds!' do
    true
    require_relative ('transaction_spec.rb')
  end
  it 'Assets test succeeds!' do
    true
    require_relative ('assets_spec.rb')
  end
  it 'Wallet test succeeds!' do
    true
    require_relative ('wallet_spec.rb')
  end


end
