require 'spec_helper'

class Resource < ActiveRecord::Base
  has_normalized_attributes :phone_attr => :phone, :zipcode_attr => :zipcode, :ssn_attr => :ssn,
                            :dollar_attr => :dollar, :taxid_attr => :taxid, :number_attr => :number,
                            :percent_attr => :percent, :spaces_attr => :spaces
end

describe "HasNormalizedFields" do
  before(:each) do
    @resource = Resource.new
  end

  describe "class method" do
    it "should work" do
      expect {
        Resource.send(:has_normalized_attributes, {:phone_attr => :phone})
      }.to_not raise_error
    end

    it "should raise an error if no fields are passed in" do
      expect {
        Resource.send(:has_normalized_attributes)
      }.to raise_error(ArgumentError, 'Must define the fields you want to be normalize with has_normalized_attributes :field_one => "phone", :field_two => "zipcode"')
    end
  end

  describe "#phone" do
    it{@resource.phone_attr = "11-111"; @resource.phone_attr.should == "11111"}
    it{@resource.phone_attr = "1111111111"; @resource.phone_attr.should == "1111111111"}
    it{@resource.phone_attr = "111 111 1111"; @resource.phone_attr.should == "1111111111"}
    it{@resource.phone_attr = " 111 111 1111 "; @resource.phone_attr.should == "1111111111"}
    it{@resource.phone_attr = "111.111.1111"; @resource.phone_attr.should == "1111111111"}
    it{@resource.phone_attr = "(111)111-1111"; @resource.phone_attr.should == "1111111111"}
    it{@resource.phone_attr = "(111)1111111"; @resource.phone_attr.should == "1111111111"}
    it{@resource.phone_attr = " 111-111.1111 "; @resource.phone_attr.should == "1111111111"}
    it{@resource.phone_attr = ""; @resource.phone_attr.should == ""}
    it{@resource.phone_attr = nil; @resource.phone_attr.should == nil}
  end

  describe "#zipcode" do
    it{@resource.zipcode_attr = "11111"; @resource.zipcode_attr.should == "11111"}
    it{@resource.zipcode_attr = " 11 1-11 "; @resource.zipcode_attr.should == "11111"}
    it{@resource.zipcode_attr = " 111-11 ("; @resource.zipcode_attr.should == "11111"}
    it{@resource.zipcode_attr = "11,1-11"; @resource.zipcode_attr.should == "11111"}
    it{@resource.zipcode_attr = "11.111"; @resource.zipcode_attr.should == "11111"}
    it{@resource.zipcode_attr = "111111111"; @resource.zipcode_attr.should == "111111111"}
    it{@resource.zipcode_attr = "(11111) 1111"; @resource.zipcode_attr.should == "111111111"}
    it{@resource.zipcode_attr = "11111) -1111"; @resource.zipcode_attr.should == "111111111"}
    it{@resource.zipcode_attr = "11111.1111"; @resource.zipcode_attr.should == "111111111"}
    it{@resource.zipcode_attr = "11111 --1111"; @resource.zipcode_attr.should == "111111111"}
    it{@resource.zipcode_attr = " 11111,1111 "; @resource.zipcode_attr.should == "111111111"}
    it{@resource.zipcode_attr = ""; @resource.zipcode_attr.should == ""}
    it{@resource.zipcode_attr = nil; @resource.zipcode_attr.should == nil}
    it{@resource.zipcode_attr = "(111)"; @resource.zipcode_attr.should == "111"}
    it{@resource.zipcode_attr = "11111"; @resource.zipcode_attr.should == "11111"}
    it{@resource.zipcode_attr = 111.11; @resource.zipcode_attr.should == 111.11}
  end

  describe "#ssn" do
    it{@resource.ssn_attr = "111 111 1111"; @resource.ssn_attr.should == "1111111111"}
    it{@resource.ssn_attr = " 111 111 1111 "; @resource.ssn_attr.should == "1111111111"}
    it{@resource.ssn_attr = "111.111.1111"; @resource.ssn_attr.should == "1111111111"}
    it{@resource.ssn_attr = "(111)111-1111"; @resource.ssn_attr.should == "1111111111"}
    it{@resource.ssn_attr = "(111)1111111"; @resource.ssn_attr.should == "1111111111"}
    it{@resource.ssn_attr = " 111-111.1111 "; @resource.ssn_attr.should == "1111111111"}
    it{@resource.ssn_attr = ""; @resource.ssn_attr.should == ""}
    it{@resource.ssn_attr = nil; @resource.ssn_attr.should == nil}
  end

  describe "#taxid" do
    it{@resource.taxid_attr = "12-345"; @resource.taxid_attr.should == "12345"}
    it{@resource.taxid_attr = "12.345"; @resource.taxid_attr.should == "12345"}
    it{@resource.taxid_attr = "1-2345"; @resource.taxid_attr.should == "12345"}
    it{@resource.taxid_attr = "1,2345"; @resource.taxid_attr.should == "12345"}
    it{@resource.taxid_attr = ""; @resource.taxid_attr.should == ""}
    it{@resource.taxid_attr = nil; @resource.taxid_attr.should == nil}
  end

  describe "#dollar" do
    it{@resource.dollar_attr = "$111111";@resource.dollar_attr.should == "111111"}
    it{@resource.dollar_attr = "111,111";@resource.dollar_attr.should == "111111"}
    it{@resource.dollar_attr = "111 111 ";@resource.dollar_attr.should == "111111"}
    it{@resource.dollar_attr = "$111, 111 ";@resource.dollar_attr.should == "111111"}
    it{@resource.dollar_attr = "";@resource.dollar_attr.should == ""}
    it{@resource.dollar_attr = nil;@resource.dollar_attr.should == nil}
  end

  describe "#number" do
    it{@resource.number_attr = "1,23";@resource.number_attr.should == "123"}
    it{@resource.number_attr = "1 23 ";@resource.number_attr.should == "123"}
    it{@resource.number_attr = "";@resource.number_attr.should == ""}
    it{@resource.number_attr = nil;@resource.number_attr.should == nil}
  end

  describe "#percent" do
    it{@resource.percent_attr = " 1 1 ";@resource.percent_attr.should == "11"}
    it{@resource.percent_attr = "11%";@resource.percent_attr.should == "11"}
    it{@resource.percent_attr = "%11";@resource.percent_attr.should == "11"}
    it{@resource.percent_attr = "1 1 % ";@resource.percent_attr.should == "11"}
    it{@resource.percent_attr = "";@resource.percent_attr.should == ""}
    it{@resource.percent_attr = nil;@resource.percent_attr.should == nil}
  end

  describe "#spaces" do
    it{@resource.spaces_attr = "5 0";@resource.spaces_attr.should == "50"}
    it{@resource.spaces_attr = "";@resource.spaces_attr.should == ""}
    it{@resource.spaces_attr = nil;@resource.spaces_attr.should == nil}
  end


end