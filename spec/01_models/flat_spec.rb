require 'rails_helper'
begin
  require "flat"
rescue LoadError
end

if defined?(Flat)
  RSpec.describe "Flat", :type => :model do
    let(:valid_attributes) do
      {
        name: 'Light & Spacious Garden Flat London',
        address: '10 Clifton Gardens London W9 1DT',
        description: 'A lovely summer feel for this spacious garden flat. Two double bedrooms, open plan living area, large kitchen and a beautiful conservatory',
        price_per_night: 75,
        number_of_guests: 3,
      }
    end

    it "has a name" do
      flat = Flat.new(name: "Light & Spacious Garden Flat London")
      expect(flat.name).to eq("Light & Spacious Garden Flat London")
    end

    it "has an address" do
      flat = Flat.new(address: "10 Clifton Gardens London W9 1DT")
      expect(flat.address).to eq("10 Clifton Gardens London W9 1DT")
    end

    it "has a description" do
      flat = Flat.new(description: "A lovely summer feel for this spacious garden flat. Two double bedrooms, open plan living area, large kitchen and a beautiful conservatory")
      expect(flat.description).to eq("A lovely summer feel for this spacious garden flat. Two double bedrooms, open plan living area, large kitchen and a beautiful conservatory")
    end

    it "has a price per night" do
      flat = Flat.new(price_per_night: 75)
      expect(flat.price_per_night).to eq(75)
    end

    it "has a number of guests" do
      flat = Flat.new(number_of_guests: 3)
      expect(flat.number_of_guests).to eq(3)
    end

    it "name cannot be blank" do
      attributes = valid_attributes
      attributes.delete(:name)
      flat = Flat.new(attributes)
      expect(flat).not_to be_valid
    end
  end
else
  describe "Flat" do
    it "should exist" do
      expect(defined?(Flat)).to eq(true)
    end
  end
end
