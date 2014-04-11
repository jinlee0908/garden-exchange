require 'spec_helper'

describe "StaticPages" do

  describe "Home Page" do

    it "should have the content 'Welcome to Garden Exchange'" do
      visit root_path
      expect(page).to have_content('Garden Exchange')
    end

    it "should have the title 'Home'" do
      visit root_path
      expect(page). to have_title('Garden Exchange | Home')
    end
  end

  describe "Search List Page" do

    it "should have the content 'Search List' " do
      visit search_list_path
      expect(page).to have_content('Search List')
    end

    it "should have the title 'Search List'" do
      visit search_list_path
      expect(page). to have_title('Garden Exchange | Search List')
    end
  end

end
