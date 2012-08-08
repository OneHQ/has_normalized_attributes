module Normalizations
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
      reg_exp = Normalizations.const_get(arg.upcase)
      define_method "normalize_#{arg}" do |value|
        value && value.is_a?(String) && value.match(reg_exp) ? value.gsub!(reg_exp,'') : value
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
        raise ArgumentError, "attribute #{field} no belongs to current class" unless columns.map(&:name).include?(field.to_s)
        define_method "#{field.to_s}=" do |value|
          if value.present?
            send "normalize_#{normalization_type.downcase}".to_sym, value.to_s
          end
          super value
        end
      end

    end
  end
end

#include activerecord
ActiveRecord::Base.send :include, Normalizations