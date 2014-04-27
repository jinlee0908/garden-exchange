require 'spec_helper'

describe "Search Pages" do

  subject { page }

  shared_examples_for "all pages" do
    it { should have_selector('h3', text: heading) }
    it { should have_title(full_title(page_title)) }
  end

  it "should have the right links on the layout" do
    visit root_path
    # click_link "FAQ"
    # expect(page).to have_title(full_title('FAQ'))
    click_link "Search"
    click_link "By Map"
    expect(page).to have_title(full_title(''))
    click_link "Search"
    click_link "By List"
    expect(page).to have_title(full_title('Search List'))
    click_link "List Item"
    expect(page).to have_title(full_title('New Item'))
  end

  describe "Home page" do
    before { visit root_path }

    it { should have_content('Garden Exchange') }
    it { should_not have_title('| Home') }

    describe "Search function" do
      let(:item) { FactoryGirl.create(:item) }
      let(:submit) { 'Save' }
      before do
        FactoryGirl.create_list(:category, 16)
        fill_in 'Where are you?', with: '1821 SE 35th Ave, Portland Or'
        fill_in 'How far do you want to look? (max 99 miles)', with: 2
        click_button "Search"
      end
        it { should have_content(item.category) }


    end
  end  

  describe "Search list page" do
    before { visit list_path }

    it { should have_content('Garden Exchange') }
    it { should have_title('Search List') }
  end


end