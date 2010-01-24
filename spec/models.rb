# Migrations ===================================================================

ActiveRecord::Schema.define do
  create_table :invoices, :force => true do |t|
    t.string :vat_number
  end
  
  create_table :optional_vat_invoices, :force => true do |t|
    t.string :vat_number
  end
  
  create_table :country_checked_invoices, :force => true do |t|
    t.string :vat_number
    t.string :country
  end
end

# Models =======================================================================

class Invoice < ActiveRecord::Base  
  validates_vat_number :vat_number
end

class OptionalVatInvoice < ActiveRecord::Base
  validates_vat_number :vat_number, :allow_blank => true
end

class CountryCheckedInvoice < ActiveRecord::Base
  validates_vat_number :vat_number, :country_method => :country_code
  
  # Logic to return the country code
  def country_code
    case country.downcase
      when 'belgium' then 'BE'
      when 'france'  then 'FR'
      when 'sweden'  then 'SE'
      else nil
    end
  end
end
