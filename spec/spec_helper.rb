# frozen_string_literal: true

require 'require_all'

require_rel '../lib/'

RSpec.configure do |c|
  c.example_status_persistence_file_path = 'examples.txt'
end
