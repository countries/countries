$LOAD_PATH << File.expand_path(File.dirname(__FILE__))

require 'YAML' unless defined?(YAML)
require 'currencies'

require 'countries/select_helper'
require 'countries/country'