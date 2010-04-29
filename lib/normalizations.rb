module Normalizations
  #CONSTANT
  ZipCode                  = /[-. )(,]/
  Phone                    = /[-. )(,]/
  Ssn                      = /[-. )(,]/
  TaxID                    = /[-. )(,]/
  Dollar                   = /[$, ]/
  Number                   = /[, ]/
  Percent                  = /[% ]/
  Spaces                   = / /

  module  Instance_methods
    def normalize(type)
      self.to_s.gsub!(type,'')
    end
  end
end

String.send(:include, Normalizations::Instance_methods)
Fixnum.send(:include, Normalizations::Instance_methods)

