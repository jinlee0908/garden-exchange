require 'spec_helper'

describe "Item Pages" do

  subject { page }

  describe "create a new item page" do
    before  { visit new_item_path }

    it { should have_content('Add a New Item') }
  end

  describe "create a new item" do
    before { visit new_item_path }

    let(:submit) { "Add my item" }

    describe "with invalid information" do

      it "should not create an item" do
        expect { click_button submit }.not_to change(Item, :count)
      end
    end

    describe "with valid information" do
      pending
    end
  end
end
