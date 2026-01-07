# frozen_string_literal: true

require "spec_helper"

class Resource < ActiveRecord::Base
  has_normalized_attributes phone_attr: :phone, zipcode_attr: :zipcode, ssn_attr: :ssn,
                            dollar_attr: :dollar, taxid_attr: :taxid, number_attr: :number,
                            percent_attr: :percent, spaces_attr: :spaces, strip_attr: :strip
end

RSpec.describe "HasNormalizedAttributes" do
  before do
    @resource = Resource.new
  end

  describe "class method" do
    it "should work" do
      expect do
        Resource.send(:has_normalized_attributes, { phone_attr: :phone })
      end.not_to raise_error
    end

    it "should raise an error if no fields are passed in" do
      expect do
        Resource.send(:has_normalized_attributes)
      end.to raise_error(
               ArgumentError,
               'Must define the fields you want to be normalize with has_normalized_attributes :field_one => "phone", :field_two => "zipcode"'
             )
    end
  end

  describe "#phone" do
    it { @resource.phone_attr = "11-111"; expect(@resource.phone_attr).to eq("11111") }
    it { @resource.phone_attr = "1111111111"; expect(@resource.phone_attr).to eq("1111111111") }
    it { @resource.phone_attr = "111 111 1111"; expect(@resource.phone_attr).to eq("1111111111") }
    it { @resource.phone_attr = " 111 111 1111 "; expect(@resource.phone_attr).to eq("1111111111") }
    it { @resource.phone_attr = "111.111.1111"; expect(@resource.phone_attr).to eq("1111111111") }
    it { @resource.phone_attr = "(111)111-1111"; expect(@resource.phone_attr).to eq("1111111111") }
    it { @resource.phone_attr = "(111)1111111"; expect(@resource.phone_attr).to eq("1111111111") }
    it { @resource.phone_attr = " 111-111.1111 "; expect(@resource.phone_attr).to eq("1111111111") }
    it { @resource.phone_attr = "0111-111.1111 "; expect(@resource.phone_attr).to eq("1111111111") }
    it { @resource.phone_attr = "1011-111.1111 "; expect(@resource.phone_attr).to eq("10111111111") }
    it { @resource.phone_attr = "111-0222.333 "; expect(@resource.phone_attr).to eq("1110222333") }
    it { @resource.phone_attr = "111-0222.333\t"; expect(@resource.phone_attr).to eq("1110222333") }
    it { @resource.phone_attr = "+1111-0222.333\t"; expect(@resource.phone_attr).to eq("1110222333") }
    it { @resource.phone_attr = "+1(111)111-1111"; expect(@resource.phone_attr).to eq("1111111111") }
    it { @resource.phone_attr = "+1 111 111 1111"; expect(@resource.phone_attr).to eq("1111111111") }
    it { @resource.phone_attr = ""; expect(@resource.phone_attr).to eq("") }
    it { @resource.phone_attr = nil; expect(@resource.phone_attr).to be_nil }
  end

  describe "#zipcode" do
    it { @resource.zipcode_attr = "11111"; expect(@resource.zipcode_attr).to eq("11111") }
    it { @resource.zipcode_attr = " 11 1-11 "; expect(@resource.zipcode_attr).to eq("11111") }
    it { @resource.zipcode_attr = " 111-11 ("; expect(@resource.zipcode_attr).to eq("11111") }
    it { @resource.zipcode_attr = "11,1-11"; expect(@resource.zipcode_attr).to eq("11111") }
    it { @resource.zipcode_attr = "11.111"; expect(@resource.zipcode_attr).to eq("11111") }
    it { @resource.zipcode_attr = "111111111"; expect(@resource.zipcode_attr).to eq("111111111") }
    it { @resource.zipcode_attr = "(11111) 1111"; expect(@resource.zipcode_attr).to eq("111111111") }
    it { @resource.zipcode_attr = "11111) -1111"; expect(@resource.zipcode_attr).to eq("111111111") }
    it { @resource.zipcode_attr = "11111\t-1111"; expect(@resource.zipcode_attr).to eq("111111111") }
    it { @resource.zipcode_attr = "11111.1111"; expect(@resource.zipcode_attr).to eq("111111111") }
    it { @resource.zipcode_attr = "11111 --1111"; expect(@resource.zipcode_attr).to eq("111111111") }
    it { @resource.zipcode_attr = " 11111,1111 "; expect(@resource.zipcode_attr).to eq("111111111") }
    it { @resource.zipcode_attr = ""; expect(@resource.zipcode_attr).to eq("") }
    it { @resource.zipcode_attr = nil; expect(@resource.zipcode_attr).to be_nil }
    it { @resource.zipcode_attr = "(111)"; expect(@resource.zipcode_attr).to eq("111") }
    it { @resource.zipcode_attr = "11111"; expect(@resource.zipcode_attr).to eq("11111") }

    skip("Possible inconsistency between ActiveRecord and SQLite") do
      @resource.zipcode_attr = 111.11
      expect(@resource.zipcode_attr).to eq(111.11)
    end
  end

  describe "#ssn" do
    it { @resource.ssn_attr = "111 111 1111"; expect(@resource.ssn_attr).to eq("1111111111") }
    it { @resource.ssn_attr = " 111 111 1111 "; expect(@resource.ssn_attr).to eq("1111111111") }
    it { @resource.ssn_attr = "111.111.1111"; expect(@resource.ssn_attr).to eq("1111111111") }
    it { @resource.ssn_attr = "(111)111-1111"; expect(@resource.ssn_attr).to eq("1111111111") }
    it { @resource.ssn_attr = "(111)1111111"; expect(@resource.ssn_attr).to eq("1111111111") }
    it { @resource.ssn_attr = " 111-111.1111 "; expect(@resource.ssn_attr).to eq("1111111111") }
    it { @resource.ssn_attr = " 111-111.1111\t"; expect(@resource.ssn_attr).to eq("1111111111") }
    it { @resource.ssn_attr = ""; expect(@resource.ssn_attr).to eq("") }
    it { @resource.ssn_attr = nil; expect(@resource.ssn_attr).to be_nil }
  end

  describe "#taxid" do
    it { @resource.taxid_attr = "12-345"; expect(@resource.taxid_attr).to eq("12345") }
    it { @resource.taxid_attr = "12.345"; expect(@resource.taxid_attr).to eq("12345") }
    it { @resource.taxid_attr = "1-2345"; expect(@resource.taxid_attr).to eq("12345") }
    it { @resource.taxid_attr = "1,2345"; expect(@resource.taxid_attr).to eq("12345") }
    it { @resource.taxid_attr = "1,2345 "; expect(@resource.taxid_attr).to eq("12345") }
    it { @resource.taxid_attr = "1,2345\t"; expect(@resource.taxid_attr).to eq("12345") }
    it { @resource.taxid_attr = ""; expect(@resource.taxid_attr).to eq("") }
    it { @resource.taxid_attr = nil; expect(@resource.taxid_attr).to be_nil }
  end

  describe "#dollar" do
    it { @resource.dollar_attr = "$111111"; expect(@resource.dollar_attr).to eq("111111") }
    it { @resource.dollar_attr = "111,111"; expect(@resource.dollar_attr).to eq("111111") }
    it { @resource.dollar_attr = "111 111 "; expect(@resource.dollar_attr).to eq("111111") }
    it { @resource.dollar_attr = "$111, 111 "; expect(@resource.dollar_attr).to eq("111111") }
    it { @resource.dollar_attr = "$111\t111\t"; expect(@resource.dollar_attr).to eq("111111") }
    it { @resource.dollar_attr = ""; expect(@resource.dollar_attr).to eq("") }
    it { @resource.dollar_attr = nil; expect(@resource.dollar_attr).to be_nil }
    it { @resource.dollar_attr = 111111.51; expect(@resource.dollar_attr).to eq("111111.51") }
    it { @resource.dollar_attr = "(321.45)"; expect(@resource.dollar_attr).to eq("-321.45") }
    it { @resource.dollar_attr = "$(321.45)"; expect(@resource.dollar_attr).to eq("-321.45") }
    it { @resource.dollar_attr = "($321.45)"; expect(@resource.dollar_attr).to eq("-321.45") }
    it { @resource.dollar_attr = BigDecimal("321.45"); expect(@resource.dollar_attr).to eq("321.45") }
  end

  describe "#number" do
    it { @resource.number_attr = "1,23"; expect(@resource.number_attr).to eq("123") }
    it { @resource.number_attr = "1 23 "; expect(@resource.number_attr).to eq("123") }
    it { @resource.number_attr = "1\t23\t"; expect(@resource.number_attr).to eq("123") }
    it { @resource.number_attr = ""; expect(@resource.number_attr).to eq("") }
    it { @resource.number_attr = nil; expect(@resource.number_attr).to be_nil }
    it { @resource.number_attr = 111111.51; expect(@resource.number_attr).to eq("111111.51") }
    it { @resource.number_attr = "(321.45)"; expect(@resource.number_attr).to eq("-321.45") }
    it { @resource.number_attr = "-321.45"; expect(@resource.number_attr).to eq("-321.45") }
    it { @resource.number_attr = BigDecimal("321.45"); expect(@resource.number_attr).to eq("321.45") }
  end

  describe "#percent" do
    it { @resource.percent_attr = " 1 1 "; expect(@resource.percent_attr).to eq("11") }
    it { @resource.percent_attr = "11%"; expect(@resource.percent_attr).to eq("11") }
    it { @resource.percent_attr = "%11"; expect(@resource.percent_attr).to eq("11") }
    it { @resource.percent_attr = "1 1 % "; expect(@resource.percent_attr).to eq("11") }
    it { @resource.percent_attr = "1\t1\t%\t"; expect(@resource.percent_attr).to eq("11") }
    it { @resource.percent_attr = ""; expect(@resource.percent_attr).to eq("") }
    it { @resource.percent_attr = nil; expect(@resource.percent_attr).to be_nil }
  end

  describe "#spaces" do
    it { @resource.spaces_attr = "5 0"; expect(@resource.spaces_attr).to eq("50") }
    it { @resource.spaces_attr = "5\t0"; expect(@resource.spaces_attr).to eq("50") }
    it { @resource.spaces_attr = ""; expect(@resource.spaces_attr).to eq("") }
    it { @resource.spaces_attr = nil; expect(@resource.spaces_attr).to be_nil }
  end

  describe "#strip" do
    it { @resource.strip_attr = "text "; expect(@resource.strip_attr).to eq("text") }
    it { @resource.strip_attr = " text"; expect(@resource.strip_attr).to eq("text") }
    it { @resource.strip_attr = " text "; expect(@resource.strip_attr).to eq("text") }
    it { @resource.strip_attr = " some text"; expect(@resource.strip_attr).to eq("some text") }
    it { @resource.strip_attr = " some text "; expect(@resource.strip_attr).to eq("some text") }
  end
end
