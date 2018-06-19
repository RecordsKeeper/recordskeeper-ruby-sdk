require "bundler/setup"
require "ruby2"

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
