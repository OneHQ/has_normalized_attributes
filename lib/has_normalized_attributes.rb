module HasNormalizedAttributes
  extend ActiveSupport::Concern

  #CONSTANT
  ZIPCODE                  = /[-. )(,]/
  PHONE                    = /[-. )(,]|(^0)/
  SSN                      = /[-. )(,]/
  TAXID                    = /[-. )(,]/
  DOLLAR                   = /[$, ]/
  NUMBER                   = /[, ]/
  PERCENT                  = /[%, ]/
  SPACES                   = /\s/

  #instance methods
  def self.normalizations(*args)
    args.each do |arg|
      define_method "normalize_#{arg}" do
        if arg == :strip
          self ? self.strip! : self
        else
          reg_exp = HasNormalizedAttributes.const_get(arg.upcase)
          self && is_a?(String) && match(reg_exp) ? gsub!(reg_exp,'') : self
        end
      end
    end
  end

  #loading all methods dynamically
  normalizations :phone, :zipcode, :ssn, :taxid, :dollar, :number, :percent, :spaces, :strip


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

#extend these classes - Numeric is a parent class for all of Ruby's numeric types.
[String, Numeric, NilClass].each do |klass|
  klass.send(:include, HasNormalizedAttributes)
end
#include activerecord
ActiveRecord::Base.send :include, HasNormalizedAttributes