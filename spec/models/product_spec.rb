require 'rails_helper'

RSpec.describe Product, type: :model do
  cat1 = Category.new({name: 'Apparel'})
  subject {
    described_class.new(name: "Sonic Screwdriver", price: 2000000,
      quantity: 3, category: cat1)
  }


  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a name" do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a price" do
    subject.price = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a quantity" do
    subject.quantity = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a category" do
    subject.category = nil
    expect(subject).to_not be_valid
  end
end