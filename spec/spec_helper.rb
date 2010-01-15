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

ActiveRecord::Schema.define do
  create_table :invoices, :force => true do |t|
    t.string :vat_number
  end
  
  create_table :optional_vat_invoices, :force => true do |t|
    t.string :vat_number
  end
end

# Utils models =================================================================

class Invoice < ActiveRecord::Base  
  validates_vat_number :vat_number
end

class OptionalVatInvoice < ActiveRecord::Base
  validates_vat_number :vat_number, :allow_blank => true
end
