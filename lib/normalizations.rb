module Normalizations
  #CONSTANT
  ZIPCODE                  = /[-. )(,]/
  PHONE                    = /[-. )(,]/
  SSN                      = /[-. )(,]/
  TAXID                    = /[-. )(,]/
  DOLLAR                   = /[$, ]/
  NUMBER                   = /[, ]/
  PERCENT                  = /[% ]/
  SPACES                   = /\s/

  module InstanceMethods
    
    def self.normalizations(*args)
      args.each do |arg|
        reg_exp = Normalizations.const_get(arg.upcase)
        define_method "normalize_#{arg}" do
          self && is_a?(String) && match(reg_exp) ? gsub!(reg_exp,'') : self
        end
      end
    end

    #loading all methods dynamically
    normalizations :phone, :zipcode, :ssn, :taxid, :dollar, :number, :percent, :spaces
  end
end
#extends class
[String, Fixnum, Float, NilClass].each do |klass|
  klass.send(:include, Normalizations::InstanceMethods)
end