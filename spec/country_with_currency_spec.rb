require "spec_helper"

describe Country do
  describe "all" do
    it "should return an array list of all countries" do
      countries = Country.all
      countries.should be_an(Array)
      countries.first.should be_an(Country)
      countries.should have(227).countries
    end
  end

  describe "dynamic finder methods" do
    context "when search name found" do
      let(:country) { Country.find_by_name("United States") }

      it "should return an array with United States country object" do
        country.should be_a(Array)
        country.first.should be_an(Country)
        country.first.iso.should == "USA"
      end
    end
    
    context "when search lowercase name found" do
      let(:country) { Country.find_by_name("united states") }

      it "should return an array with United States country object" do
        country.should be_a(Array)
        country.first.should be_an(Country)
        country.first.iso.should == "USA"
      end
    end
    
    context "when search name not found" do
      it "should raise Country::UnknownCountry error" do
        lambda { Country.find_by_name("Invalid Country") }.should raise_error(Country::UnknownCountry, "Country not found.")
      end
    end
    
    context "when search by invalid attribute" do
      it "should raise Country::UnknownAttribute error" do
        lambda { Country.find_by_invalid("Invalid Country") }.should raise_error(Country::UnknownAttribute, "Invalid attribute 'invalid'.")
      end
    end
  end
end