require 'rubygems'
require 'spec'
require 'active_support'
require 'active_record'
require 'action_controller'
require 'action_view'

require File.dirname(__FILE__) + '/../lib/validates_vat_number.rb'
 
# ActiveRecord setup ===========================================================

ActiveRecord::Base.establish_connection({
    :adapter => 'sqlite3',
    :database => 'test.db'
})

require 'models'