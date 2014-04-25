require 'spec_helper'

describe "Search Pages" do

  subject { page }

  describe "Home page" do
    before { visit root_path }

    it { should have_content('Garden Exchange') }
    it { should_not have_title('| Home') }
  end  

  describe "Search list page" do
    before { visit list_path }

    it { should have_content('Garden Exchange') }
    it { should have_title('Search List') }
  end


end