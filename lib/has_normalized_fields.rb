module HasNormalizedFields
  extend ActiveSupport::Concern

  #CONSTANT
  ZIPCODE                  = /[-. )(,]/
  PHONE                    = /[-. )(,]/
  SSN                      = /[-. )(,]/
  TAXID                    = /[-. )(,]/
  DOLLAR                   = /[$, ]/
  NUMBER                   = /[, ]/
  PERCENT                  = /[% ]/
  SPACES                   = /\s/

  #instance methods
  def self.normalizations(*args)
    args.each do |arg|
      reg_exp = HasNormalizedFields.const_get(arg.upcase)
      define_method "normalize_#{arg}" do
        self && is_a?(String) && match(reg_exp) ? gsub!(reg_exp,'') : self
      end
    end
  end

  #loading all methods dynamically
  normalizations :phone, :zipcode, :ssn, :taxid, :dollar, :number, :percent, :spaces


  module ClassMethods
    def has_normalized_attributes(args = {})

      if args.blank? || !args.is_a?(Hash)
        raise ArgumentError, 'Must define the fields you want to be normalize with has_normalized_attributes :field_one => "phone", :field_two => "zipcode"'
      end

      args.each do |field, normalization_type|
        define_method "#{field.to_s}=" do |value|
          if value.present?
            value.send("normalize_#{normalization_type.downcase}".to_sym)
          end
          super value
        end
      end

    end
  end
end

#extend these classes
[String, Fixnum, Float, NilClass].each do |klass|
  klass.send(:include, HasNormalizedFields)
end
#include activerecord
ActiveRecord::Base.send :include, HasNormalizedFields