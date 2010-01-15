module ValidatesVatNumber
  VAT_PATTERNS = {
    'DE' => /\ADE[0-9]{9}\Z/,                                # Germany
    'AT' => /\AATU[0-9]{8}\Z/,                               # Austria
    'BE' => /\ABE[0-9]{10}\Z/,                               # Belgium
    'BG' => /\ABG[0-9]{9,10}\Z/,                             # Bulgaria
    'CY' => /\ACY[0-9]{8}[A-Z]\Z/,                           # Cyprus
    'DK' => /\ADK[0-9]{8}\Z/,                                # Denmark
    'ES' => /\AES[0-9]{9}\Z/,                                # Spain
    'EE' => /\AEE[0-9]{9}\Z/,                                # Estonia
    'FI' => /\AFI[0-9]{8}\Z/,                                # Finland
    'FR' => /\AFR[A-Z0-9]{2}[0-9]{9}\Z/,                     # France
    'EL' => /\AEL[0-9]{9}\Z/,                                # Greece
    'HU' => /\AHU[0-9]{8}\Z/,                                # Hungary
    'IE' => /\AIE([0-9][A-Z][0-9]{5}[A-Z]|[0-9]{7}[A-Z])\Z/, # Ireland
    'IT' => /\AIT[0-9]{11}\Z/,                               # Italy
    'LV' => /\ALV[0-9]{11}\Z/,                               # Latvia
    'LT' => /\ALT([0-9]{9}|[0-9]{12})\Z/,                    # Lithuania
    'LU' => /\ALU[0-9]{8}\Z/,                                # Luxembourg
    'MT' => /\AMT[0-9]{8}\Z/,                                # Malta
    'NL' => /\ANL[0-9]{9}[A-Z][0-9]{2}\Z/,                   # Netherlands
    'PL' => /\APL[0-9]{10}\Z/,                               # Poland
    'PT' => /\APT[0-9]{9}\Z/,                                # Portugal
    'GB' => /\AGB([0-9]{9}|[A-Z0-9]{2}[0-9]{3})\Z/,          # United Kingdom
    'RO' => /\ARO[0-9]{9}\Z/,                                # Romania
    'SK' => /\ASK[0-9]{10}\Z/,                               # Slovakia
    'SI' => /\ASI[0-9]{8}\Z/,                                # Slovenia
    'SE' => /\ASE[0-9]{12}\Z/,                               # Sweden
    'CZ' => /\ACZ[0-9]{8,10}\Z/                              # Czech Republic
  }
end

class ActiveRecord::Base
  def self.validates_vat_number(*attr_names)
    configuration = { :on => :save, :allow_blank => false }
    configuration.update(attr_names.extract_options!)
    
    validates_each(attr_names, configuration) do |record, attr_name, value|
      if configuration[:country_method]
        country = self.send(options[:country_field]).to_s
        if !ValidatesVatNumber::VAT_PATTERNS.has_key?(country) || value.to_s =~ ValidatesVatNumber::VAT_PATTERNS[country]
          errors.add(field_sym, :invalid)
        end
      else
        unless ValidatesVatNumber::VAT_PATTERNS.values.detect { |p| value.to_s =~ p }
          record.errors.add(attr_name, configuration[:message])
        end
      end
    end
  end
end

# ActiveModel/Rails 3 style ? :

# module ActiveModel
#   module Validations
#     module ClassMethods     
#       def validates_vat_number(*attr_names)
#         configuration = {
#           :message => ActiveRecord::Errors.default_error_messages[:invalid],
#           :on => :save,
#           :with => nil
#         }
#         
#         validates_each(attr_names, configuration) do |record, attr_name, value|
#           unless configuration[:allow_blank] && value.to_s.blank?
#             unless ValidatesVatNumber::VAT_PATTERNS.values.detect { |p| value.to_s =~ p }
#               record.errors.add(attr_name, configuration[:message])
#             end
#           end
#         end
#       end
#     end
#   end
# end