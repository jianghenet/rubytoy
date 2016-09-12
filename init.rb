#
$LOAD_PATH << File.absolute_path('.')
require 'pry'
require "zlib"
require "base64"
require 'active_support'
require 'active_support/all'
require 'lib/model'
require 'china_voin'
require 'name_database'
require 'models/transaction'
require 'models/user'
require 'root'

def rndbool
  rand(2) > 0
end

if __FILE__ == $0
  $name_database = NameDatabase.new
  $root = Root.new
  thread = Thread.new{
    while true
      $root.trade
      sleep 5
    end
  }
  
  while true
  end

end
