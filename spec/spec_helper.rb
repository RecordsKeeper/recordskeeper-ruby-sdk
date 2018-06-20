require "bundler/setup"
require "RecordsKeeperRuby"

# RSpec.configure do |config|
#   # Enable flags like --only-failures and --next-failure
#   config.example_status_persistence_file_path = ".rspec_status"
#
#   # Disable RSpec exposing methods globally on `Module` and `main`
#   config.disable_monkey_patching!
#
#   config.expect_with :rspec do |c|
#     c.syntax = :expect
#   end
# end

RSpec.configure { |c| c.fail_if_no_examples = true }

  $LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
  require_relative ('address_spec.rb')
  require_relative ('block_spec.rb')
  require_relative ('blockchain_spec.rb')
  require_relative ('permissions_spec.rb')
  require_relative ('stream_spec.rb')
  require_relative ('transaction_spec.rb')
  require_relative ('assets_spec.rb')
  require_relative ('wallet_spec.rb')
