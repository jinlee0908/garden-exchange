require 'spec_helper'

describe Item do 

  before { @item = Item.new(name: "Example Item", description: "This is an example.",
                            location: "123 First Street, Portland Oregon", email: "example@example.com",
                            phone: "123-456-7890", trade_status: "", image_id: "",
                            category_id: 123 ) }

  subject { @item }

  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:location) }
  it { should respond_to(:email) }
  it { should respond_to(:phone) }
  it { should respond_to(:trade_status) }
  it { should respond_to(:image_id) }
  it { should respond_to(:category_id) }

  it { should be_valid }

  describe "when location is not present" do
    before { @item.location = " " }
    it { should_not be_valid }
  end

  describe "when email or text is not present" do
    before { @item.email = "" } 
    before { @item.phone = ""}
    it { should_not be_valid }
  end

  describe "when email only is present" do
    before { @item.email = "example@example.com" }
    before { @item.phone = "" }
    it { should be_valid }
  end

  describe "when phone only is present" do
    before { @item.email = "" }
    before { @item.phone = "123-456-7890"}
    it { should be_valid }
  end

  describe "when category id is not present" do
    before { @item.category_id = nil }
    it { should_not be_valid }
  end

  describe "when description is too long" do
    before { @item.description = "a" * 141 }
    it { should_not be_valid }
  end

end
