require "rspec"
require "rspec_matchers"

RSpec.configure do |c|
  c.filter_run_excluding(:live => true)
  c.filter_run_excluding(:broken => true)
  c.include(RspecMatchers)
end