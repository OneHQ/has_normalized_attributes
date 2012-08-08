require 'spec_helper'

describe Sample do
  before(:each) do
    @sample = Sample.new
  end

  describe "ZIPCODE" do
    it{@sample.value = "11111";@sample.value.normalize_zipcode.should == "11111"}
    it{@sample.value = " 11 1-11 ";@sample.value.normalize_zipcode.should == "11111"}
    it{@sample.value = " 111-11 (";@sample.value.normalize_zipcode.should == "11111"}
    it{@sample.value = "11,1-11";@sample.value.normalize_zipcode.should == "11111"}
    it{@sample.value = "11.111";@sample.value.normalize_zipcode.should == "11111"}

    it{@sample.value = "111111111";@sample.value.normalize_zipcode.should == "111111111"}
    it{@sample.value = "(11111) 1111";@sample.value.normalize_zipcode.should == "111111111"}
    it{@sample.value = "11111) -1111";@sample.value.normalize_zipcode.should == "111111111"}
    it{@sample.value = "11111.1111";@sample.value.normalize_zipcode.should == "111111111"}
    it{@sample.value = "11111 --1111";@sample.value.normalize_zipcode.should == "111111111"}
    it{@sample.value = " 11111,1111 ";@sample.value.normalize_zipcode.should == "111111111"}

    it{@sample.value = "";@sample.value.normalize_zipcode.should == ""}
    it{@sample.value = nil;@sample.value.normalize_zipcode.should == nil}
    it{@sample.value = "(111)";@sample.value.normalize_zipcode.should == "111"}
    it{@sample.value = "11111";@sample.value.normalize_zipcode.should == "11111"}
    it{@sample.value = 111.11;@sample.value.normalize_zipcode.should == 111.11}
  end

  describe "PHONE" do
    it{@sample.value = "1111111111";@sample.value.normalize_phone.should == "1111111111"}
    it{@sample.value = "111 111 1111";@sample.value.normalize_phone.should == "1111111111"}
    it{@sample.value = " 111 111 1111 ";@sample.value.normalize_phone.should == "1111111111"}
    it{@sample.value = "111.111.1111";@sample.value.normalize_phone.should == "1111111111"}
    it{@sample.value = "(111)111-1111";@sample.value.normalize_phone.should == "1111111111"}
    it{@sample.value = "(111)1111111";@sample.value.normalize_phone.should == "1111111111"}
    it{@sample.value = " 111-111.1111 ";@sample.value.normalize_phone.should == "1111111111"}

    it{@sample.value = "";@sample.value.normalize_phone.should == ""}
    it{@sample.value = nil;@sample.value.normalize_phone.should == nil}
  end

  describe "SSN" do
    it{@sample.value = "111 111 1111";@sample.value.normalize_ssn.should == "1111111111"}
    it{@sample.value = " 111 111 1111 ";@sample.value.normalize_ssn.should == "1111111111"}
    it{@sample.value = "111.111.1111";@sample.value.normalize_ssn.should == "1111111111"}
    it{@sample.value = "(111)111-1111";@sample.value.normalize_ssn.should == "1111111111"}
    it{@sample.value = "(111)1111111";@sample.value.normalize_ssn.should == "1111111111"}
    it{@sample.value = " 111-111.1111 ";@sample.value.normalize_ssn.should == "1111111111"}

    it{@sample.value = "";@sample.value.normalize_ssn.should == ""}
    it{@sample.value = nil;@sample.value.normalize_ssn.should == nil}
  end

  describe "TAXID" do
    it{@sample.value = "12-345";@sample.value.normalize_taxid.should == "12345"}
    it{@sample.value = "12.345";@sample.value.normalize_taxid.should == "12345"}
    it{@sample.value = "1-2345";@sample.value.normalize_taxid.should == "12345"}
    it{@sample.value = "1,2345";@sample.value.normalize_taxid.should == "12345"}

    it{@sample.value = "";@sample.value.normalize_taxid.should == ""}
    it{@sample.value = nil;@sample.value.normalize_taxid.should == nil}
  end

  describe "DOLLAR" do
    it{@sample.value = "$111111";@sample.value.normalize_dollar.should == "111111"}
    it{@sample.value = "111,111";@sample.value.normalize_dollar.should == "111111"}
    it{@sample.value = "111 111 ";@sample.value.normalize_dollar.should == "111111"}
    it{@sample.value = "$111, 111 ";@sample.value.normalize_dollar.should == "111111"}

    it{@sample.value = "";@sample.value.normalize_dollar.should == ""}
    it{@sample.value = nil;@sample.value.normalize_dollar.should == nil}
  end

  describe "NUMBER" do
    it{@sample.value = "1,23";@sample.value.normalize_number.should == "123"}
    it{@sample.value = "1 23 ";@sample.value.normalize_number.should == "123"}

    it{@sample.value = "";@sample.value.normalize_number.should == ""}
    it{@sample.value = nil;@sample.value.normalize_number.should == nil}
  end

  describe "PERCENT" do
    it{@sample.value = " 1 1 ";@sample.value.normalize_percent.should == "11"}
    it{@sample.value = "11%";@sample.value.normalize_percent.should == "11"}
    it{@sample.value = "%11";@sample.value.normalize_percent.should == "11"}
    it{@sample.value = "1 1 % ";@sample.value.normalize_percent.should == "11"}

    it{@sample.value = "";@sample.value.normalize_percent.should == ""}
    it{@sample.value = nil;@sample.value.normalize_percent.should == nil}
  end

  describe "SPACES" do
    it{@sample.value = "5 0";@sample.value.normalize_spaces.should == "50"}

    it{@sample.value = "";@sample.value.normalize_spaces.should == ""}
    it{@sample.value = nil;@sample.value.normalize_spaces.should == nil}
  end
end
