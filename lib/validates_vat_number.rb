module ActiveRecord
  module ValidatesVatNumber
    
    # Contants =================================================================
    
    VAT_PATTERNS = {
      'Germany'        => /^DE[0-9]{9}$/,
      'Austria'        => /^ATU[0-9]{8}$/,
      'Belgium'        => /^BE[0-9]{10}$/,
      'Bulgaria'       => /^BG[0-9]{9,10}$/,
      'Cyprus'         => /^CY[0-9]{8}[A-Z]$/,
      'Denmark'        => /^DK[0-9]{8}$/,
      'Spain'          => /^ES[0-9]{9}$/,
      'Estonia'        => /^EE[0-9]{9}$/,
      'Finland'        => /^FI[0-9]{8}$/,
      'France'         => /^FR[A-Z0-9]{2}[0-9]{9}$/,
      'Greece'         => /^EL[0-9]{9}$/,
      'Hungary'        => /^HU[0-9]{8}$/,
      'Ireland'        => /^IE([0-9][A-Z][0-9]{5}[A-Z]|[0-9]{7}[A-Z])$/,
      'Italy'          => /^IT[0-9]{11}$/,
      'Latvia'         => /^LV[0-9]{11}$/,
      'Lithuania'      => /^LT([0-9]{9}|[0-9]{12})$/,
      'Luxembourg'     => /^LU[0-9]{8}$/,
      'Malta'          => /^MT[0-9]{8}$/,
      'Netherlands'    => /^NL[0-9]{9}[A-Z][0-9]{2}$/,
      'Poland'         => /^PL[0-9]{10}$/,
      'Portugal'       => /^PT[0-9]{9}$/,
      'United Kingdom' => /^GB([0-9]{9}|[A-Z0-9]{2}[0-9]{3})$/,
      'Romania'        => /^RO[0-9]{9}$/,
      'Slovakia'       => /^SK[0-9]{10}$/,
      'Slovenia'       => /^SI[0-9]{8}$/,
      'Sweden'         => /^SE[0-9]{12}$/,
      'Czech Republic' => /^CZ[0,9]{8,10}$/
    }
    
    VAT_PATTERNS = {
      'DE' => /^DE[0-9]{9}$/,                                # Germany
      'AT' => /^ATU[0-9]{8}$/,                               # Austria
      'BE' => /^BE[0-9]{10}$/,                               # Belgium
      'BG' => /^BG[0-9]{9,10}$/,                             # Bulgaria
      'CY' => /^CY[0-9]{8}[A-Z]$/,                           # Cyprus
      'DK' => /^DK[0-9]{8}$/,                                # Denmark
      'ES' => /^ES[0-9]{9}$/,                                # Spain
      'EE' => /^EE[0-9]{9}$/,                                # Estonia
      'FI' => /^FI[0-9]{8}$/,                                # Finland
      'FR' => /^FR[A-Z0-9]{2}[0-9]{9}$/,                     # France
      'EL' => /^EL[0-9]{9}$/,                                # Greece
      'HU' => /^HU[0-9]{8}$/,                                # Hungary
      'IE' => /^IE([0-9][A-Z][0-9]{5}[A-Z]|[0-9]{7}[A-Z])$/, # Ireland
      'IT' => /^IT[0-9]{11}$/,                               # Italy
      'LV' => /^LV[0-9]{11}$/,                               # Latvia
      'LT' => /^LT([0-9]{9}|[0-9]{12})$/,                    # Lithuania
      'LU' => /^LU[0-9]{8}$/,                                # Luxembourg
      'MT' => /^MT[0-9]{8}$/,                                # Malta
      'NL' => /^NL[0-9]{9}[A-Z][0-9]{2}$/,                   # Netherlands
      'PL' => /^PL[0-9]{10}$/,                               # Poland
      'PT' => /^PT[0-9]{9}$/,                                # Portugal
      'GB' => /^GB([0-9]{9}|[A-Z0-9]{2}[0-9]{3})$/,          # United Kingdom
      'RO' => /^RO[0-9]{9}$/,                                # Romania
      'SK' => /^SK[0-9]{10}$/,                               # Slovakia
      'SI' => /^SI[0-9]{8}$/,                                # Slovenia
      'SE' => /^SE[0-9]{12}$/,                               # Sweden
      'CZ' => /^CZ[0,9]{8,10}$/                              # Czech Republic
    }
    
    # Class methods ============================================================
  
    def self.included(base)
      base.extend(ClassMethods)
    end
  
    module ClassMethods
      def validates_vat_number(field_sym, options = {})
        if options[:country_field]
          if VAT_PATTERNS.has_key?(instance_variable_get("@#{country_field}"))
            unless instance_variable_get("@#{field_sym}") =~ VAT_PATTERNS[instance_variable_get("@#{country_field}")]
              errors.add(field_sym, :invalid)
            end
          end
        end
      end
    end
  end
end