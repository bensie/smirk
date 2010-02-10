require 'rest_client'
require 'json'
require File.expand_path(File.dirname(__FILE__) + '/smirk/client')
require File.expand_path(File.dirname(__FILE__) + '/smirk/album')
require File.expand_path(File.dirname(__FILE__) + '/smirk/image')

module Smirk
  class AccessDenied < StandardError; end
end