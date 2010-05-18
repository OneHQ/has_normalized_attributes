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
      if self && self.match(type)
        self.to_s.gsub!(type,'')
      else
        self
      end
    end
  end

end

String.send(:include, Normalizations::Instance_methods)
Fixnum.send(:include, Normalizations::Instance_methods)
NilClass.send(:include, Normalizations::Instance_methods)

