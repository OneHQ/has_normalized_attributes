require File.dirname(__FILE__) + '/base'

describe Sample do
  before(:each) do
    @sample = Sample.new
  end

  describe "ZIPCODE" do
    it{@sample.value = "11111";@sample.value.normalize(Normalizations::ZIPCODE).should == "11111"}
    it{@sample.value = " 11 1-11 ";@sample.value.normalize(Normalizations::ZIPCODE).should == "11111"}
    it{@sample.value = " 111-11 (";@sample.value.normalize(Normalizations::ZIPCODE).should == "11111"}
    it{@sample.value = "11,1-11";@sample.value.normalize(Normalizations::ZIPCODE).should == "11111"}
    it{@sample.value = "11.111";@sample.value.normalize(Normalizations::ZIPCODE).should == "11111"}

    it{@sample.value = "111111111";@sample.value.normalize(Normalizations::ZIPCODE).should == "111111111"}
    it{@sample.value = "(11111) 1111";@sample.value.normalize(Normalizations::ZIPCODE).should == "111111111"}
    it{@sample.value = "11111) -1111";@sample.value.normalize(Normalizations::ZIPCODE).should == "111111111"}
    it{@sample.value = "11111.1111";@sample.value.normalize(Normalizations::ZIPCODE).should == "111111111"}
    it{@sample.value = "11111 --1111";@sample.value.normalize(Normalizations::ZIPCODE).should == "111111111"}
    it{@sample.value = " 11111,1111 ";@sample.value.normalize(Normalizations::ZIPCODE).should == "111111111"}

    it{@sample.value = "";@sample.value.normalize(Normalizations::ZIPCODE).should == ""}
    it{@sample.value = nil;@sample.value.normalize(Normalizations::ZIPCODE).should == nil}
    it{@sample.value = "(111)";@sample.value.normalize(Normalizations::ZIPCODE).should == "111"}
    it{@sample.value = "11111";@sample.value.normalize(Normalizations::ZIPCODE).should == "11111"}
    it{@sample.value = 111.11;@sample.value.normalize(Normalizations::ZIPCODE).should == "11111"}
  end

  describe "PHONE" do
    it{@sample.value = "1111111111";@sample.value.normalize(Normalizations::PHONE).should == "1111111111"}
    it{@sample.value = "111 111 1111";@sample.value.normalize(Normalizations::PHONE).should == "1111111111"}
    it{@sample.value = " 111 111 1111 ";@sample.value.normalize(Normalizations::PHONE).should == "1111111111"}
    it{@sample.value = "111.111.1111";@sample.value.normalize(Normalizations::PHONE).should == "1111111111"}
    it{@sample.value = "(111)111-1111";@sample.value.normalize(Normalizations::PHONE).should == "1111111111"}
    it{@sample.value = "(111)1111111";@sample.value.normalize(Normalizations::PHONE).should == "1111111111"}
    it{@sample.value = " 111-111.1111 ";@sample.value.normalize(Normalizations::PHONE).should == "1111111111"}

    it{@sample.value = "";@sample.value.normalize(Normalizations::PHONE).should == ""}
    it{@sample.value = nil;@sample.value.normalize(Normalizations::PHONE).should == nil}
  end

  describe "SSN" do
    it{@sample.value = "111 111 1111";@sample.value.normalize(Normalizations::SSN).should == "1111111111"}
    it{@sample.value = " 111 111 1111 ";@sample.value.normalize(Normalizations::SSN).should == "1111111111"}
    it{@sample.value = "111.111.1111";@sample.value.normalize(Normalizations::SSN).should == "1111111111"}
    it{@sample.value = "(111)111-1111";@sample.value.normalize(Normalizations::SSN).should == "1111111111"}
    it{@sample.value = "(111)1111111";@sample.value.normalize(Normalizations::SSN).should == "1111111111"}
    it{@sample.value = " 111-111.1111 ";@sample.value.normalize(Normalizations::SSN).should == "1111111111"}

    it{@sample.value = "";@sample.value.normalize(Normalizations::SSN).should == ""}
    it{@sample.value = nil;@sample.value.normalize(Normalizations::SSN).should == nil}
  end

  describe "TAXID" do
    it{@sample.value = "12-345";@sample.value.normalize(Normalizations::TAXID).should == "12345"}
    it{@sample.value = "12.345";@sample.value.normalize(Normalizations::TAXID).should == "12345"}
    it{@sample.value = "1-2345";@sample.value.normalize(Normalizations::TAXID).should == "12345"}
    it{@sample.value = "1,2345";@sample.value.normalize(Normalizations::TAXID).should == "12345"}

    it{@sample.value = "";@sample.value.normalize(Normalizations::TAXID).should == ""}
    it{@sample.value = nil;@sample.value.normalize(Normalizations::TAXID).should == nil}
  end

  describe "DOLLAR" do
    it{@sample.value = "$111111";@sample.value.normalize(Normalizations::DOLLAR).should == "111111"}
    it{@sample.value = "111,111";@sample.value.normalize(Normalizations::DOLLAR).should == "111111"}
    it{@sample.value = "111 111 ";@sample.value.normalize(Normalizations::DOLLAR).should == "111111"}
    it{@sample.value = "$111, 111 ";@sample.value.normalize(Normalizations::DOLLAR).should == "111111"}

    it{@sample.value = "";@sample.value.normalize(Normalizations::DOLLAR).should == ""}
    it{@sample.value = nil;@sample.value.normalize(Normalizations::DOLLAR).should == nil}
  end

  describe "NUMBER" do
    it{@sample.value = "1,23";@sample.value.normalize(Normalizations::NUMBER).should == "123"}
    it{@sample.value = "1 23 ";@sample.value.normalize(Normalizations::NUMBER).should == "123"}

    it{@sample.value = "";@sample.value.normalize(Normalizations::NUMBER).should == ""}
    it{@sample.value = nil;@sample.value.normalize(Normalizations::NUMBER).should == nil}
  end

  describe "PERCENT" do
    it{@sample.value = " 1 1 ";@sample.value.normalize(Normalizations::PERCENT).should == "11"}
    it{@sample.value = "11%";@sample.value.normalize(Normalizations::PERCENT).should == "11"}
    it{@sample.value = "%11";@sample.value.normalize(Normalizations::PERCENT).should == "11"}
    it{@sample.value = "1 1 % ";@sample.value.normalize(Normalizations::PERCENT).should == "11"}

    it{@sample.value = "";@sample.value.normalize(Normalizations::PERCENT).should == ""}
    it{@sample.value = nil;@sample.value.normalize(Normalizations::PERCENT).should == nil}
  end

  describe "SPACES" do
    it{@sample.value = "5 0";@sample.value.normalize(Normalizations::SPACES).should == "50"}

    it{@sample.value = "";@sample.value.normalize(Normalizations::SPACES).should == ""}
    it{@sample.value = nil;@sample.value.normalize(Normalizations::SPACES).should == nil}
  end
end

