module Normalizations
  mattr_accessor :zipcode, :phone, :ssn, :taxid, :dollar, :number, :percent, :spaces

  self.zipcode                  = /[-. )(,]/
  self.phone                    = /[-. )(,]/
  self.ssn                      = /[-. )(,]/
  self.taxid                    = /[-. )(,]/
  self.dollar                   = /[$, ]/
  self.number                   = /[, ]/  
  self.percent                  = /[% ]/
  self.spaces                   = / / 
end