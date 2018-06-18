# RSpec.describe Ruby2 do
#   it "has a version number" do
#     expect(Ruby2::VERSION).not_to be nil
#   end
#
#   it "does something useful" do
#     expect(false).to eq(true)
#   end
# end
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require_relative ('test_address.rb')
require_relative ('test_block.rb')
require_relative ('test_blockchain.rb')
require_relative ('test_permissions.rb')
require_relative ('test_stream.rb')
require_relative ('test_transaction.rb')
