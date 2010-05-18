require File.dirname(__FILE__) + '/base'

describe Sample do
  before(:each) do
    @sample = Sample.new
  end

  describe "ZipCode" do
    it{@sample.value = "11111";@sample.value.normalize(Normalizations::ZipCode).should == "11111"}
    it{@sample.value = " 11 1-11 ";@sample.value.normalize(Normalizations::ZipCode).should == "11111"}
    it{@sample.value = " 111-11 (";@sample.value.normalize(Normalizations::ZipCode).should == "11111"}
    it{@sample.value = "11,1-11";@sample.value.normalize(Normalizations::ZipCode).should == "11111"}
    it{@sample.value = "11.111";@sample.value.normalize(Normalizations::ZipCode).should == "11111"}

    it{@sample.value = "111111111";@sample.value.normalize(Normalizations::ZipCode).should == "111111111"}
    it{@sample.value = "(11111) 1111";@sample.value.normalize(Normalizations::ZipCode).should == "111111111"}
    it{@sample.value = "11111) -1111";@sample.value.normalize(Normalizations::ZipCode).should == "111111111"}
    it{@sample.value = "11111.1111";@sample.value.normalize(Normalizations::ZipCode).should == "111111111"}
    it{@sample.value = "11111 --1111";@sample.value.normalize(Normalizations::ZipCode).should == "111111111"}
    it{@sample.value = " 11111,1111 ";@sample.value.normalize(Normalizations::ZipCode).should == "111111111"}

    it{@sample.value = "";@sample.value.normalize(Normalizations::ZipCode).should == ""}
    it{@sample.value = nil;@sample.value.normalize(Normalizations::ZipCode).should == nil}
    it{@sample.value = "(111)";@sample.value.normalize(Normalizations::ZipCode).should == "111"}
    it{@sample.value = "11111";@sample.value.normalize(Normalizations::ZipCode).should == "11111"}
  end

  describe "Phone" do
    it{@sample.value = "1111111111";@sample.value.normalize(Normalizations::Phone).should == "1111111111"}
    it{@sample.value = "111 111 1111";@sample.value.normalize(Normalizations::Phone).should == "1111111111"}
    it{@sample.value = " 111 111 1111 ";@sample.value.normalize(Normalizations::Phone).should == "1111111111"}
    it{@sample.value = "111.111.1111";@sample.value.normalize(Normalizations::Phone).should == "1111111111"}
    it{@sample.value = "(111)111-1111";@sample.value.normalize(Normalizations::Phone).should == "1111111111"}
    it{@sample.value = "(111)1111111";@sample.value.normalize(Normalizations::Phone).should == "1111111111"}
    it{@sample.value = " 111-111.1111 ";@sample.value.normalize(Normalizations::Phone).should == "1111111111"}

    it{@sample.value = "";@sample.value.normalize(Normalizations::Phone).should == ""}
    it{@sample.value = nil;@sample.value.normalize(Normalizations::Phone).should == nil}
  end

  describe "Ssn" do
    it{@sample.value = "111 111 1111";@sample.value.normalize(Normalizations::Ssn).should == "1111111111"}
    it{@sample.value = " 111 111 1111 ";@sample.value.normalize(Normalizations::Ssn).should == "1111111111"}
    it{@sample.value = "111.111.1111";@sample.value.normalize(Normalizations::Ssn).should == "1111111111"}
    it{@sample.value = "(111)111-1111";@sample.value.normalize(Normalizations::Ssn).should == "1111111111"}
    it{@sample.value = "(111)1111111";@sample.value.normalize(Normalizations::Ssn).should == "1111111111"}
    it{@sample.value = " 111-111.1111 ";@sample.value.normalize(Normalizations::Ssn).should == "1111111111"}

    it{@sample.value = "";@sample.value.normalize(Normalizations::Ssn).should == ""}
    it{@sample.value = nil;@sample.value.normalize(Normalizations::Ssn).should == nil}
  end

  describe "TaxID" do
    it{@sample.value = "12-345";@sample.value.normalize(Normalizations::TaxID).should == "12345"}
    it{@sample.value = "12.345";@sample.value.normalize(Normalizations::TaxID).should == "12345"}
    it{@sample.value = "1-2345";@sample.value.normalize(Normalizations::TaxID).should == "12345"}
    it{@sample.value = "1,2345";@sample.value.normalize(Normalizations::TaxID).should == "12345"}

    it{@sample.value = "";@sample.value.normalize(Normalizations::TaxID).should == ""}
    it{@sample.value = nil;@sample.value.normalize(Normalizations::TaxID).should == nil}
  end

  describe "Dollar" do
    it{@sample.value = "$111111";@sample.value.normalize(Normalizations::Dollar).should == "111111"}
    it{@sample.value = "111,111";@sample.value.normalize(Normalizations::Dollar).should == "111111"}
    it{@sample.value = "111 111 ";@sample.value.normalize(Normalizations::Dollar).should == "111111"}
    it{@sample.value = "$111, 111 ";@sample.value.normalize(Normalizations::Dollar).should == "111111"}

    it{@sample.value = "";@sample.value.normalize(Normalizations::Dollar).should == ""}
    it{@sample.value = nil;@sample.value.normalize(Normalizations::Dollar).should == nil}
  end

  describe "Number" do
    it{@sample.value = "1,23";@sample.value.normalize(Normalizations::Number).should == "123"}
    it{@sample.value = "1 23 ";@sample.value.normalize(Normalizations::Number).should == "123"}

    it{@sample.value = "";@sample.value.normalize(Normalizations::Number).should == ""}
    it{@sample.value = nil;@sample.value.normalize(Normalizations::Number).should == nil}
  end

  describe "Percent" do
    it{@sample.value = " 1 1 ";@sample.value.normalize(Normalizations::Percent).should == "11"}
    it{@sample.value = "11%";@sample.value.normalize(Normalizations::Percent).should == "11"}
    it{@sample.value = "%11";@sample.value.normalize(Normalizations::Percent).should == "11"}
    it{@sample.value = "1 1 % ";@sample.value.normalize(Normalizations::Percent).should == "11"}

    it{@sample.value = "";@sample.value.normalize(Normalizations::Percent).should == ""}
    it{@sample.value = nil;@sample.value.normalize(Normalizations::Percent).should == nil}
  end

  describe "Spaces" do
    it{@sample.value = "5 0";@sample.value.normalize(Normalizations::Spaces).should == "50"}

    it{@sample.value = "";@sample.value.normalize(Normalizations::Spaces).should == ""}
    it{@sample.value = nil;@sample.value.normalize(Normalizations::Spaces).should == nil}
  end
end

