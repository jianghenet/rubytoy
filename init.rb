#
$LOAD_PATH << File.absolute_path('.')
require 'pry'
require "zlib"
require "base64"
require 'active_support'
require 'lib/model'
require 'china_voin'
require 'name_database'
require 'models/transaction'
require 'models/user'

if __FILE__ == $0
  $name_database = NameDatabase.new
  pry
end
