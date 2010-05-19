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
      if self && self.to_s.match(type)
        self.to_s.gsub!(type,'')
      else
        self
      end
    end
  end

end

#extends class
[String, Fixnum, Float, NilClass].each do |klass|
  klass.send(:include, Normalizations::Instance_methods)
end

