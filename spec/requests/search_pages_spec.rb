require 'spec_helper'

describe "Search Pages" do

  subject { page }

  shared_examples_for "all pages" do
    it { should have_selector('h3', text: heading) }
  end

  it "should have the right links on the layout" do
    visit root_path
    click_link "How It Works"
    expect(page).to have_title(full_title('How it Works'))
    click_link "Search"
    click_link "By Map"
    expect(page).to have_title('')
    expect(page).to have_content('Welcome')
    click_link "Search"
    click_link "By List"
    expect(page).to have_title('Search List')
    expect(page).to have_content('Description')
    click_link "List Item"
    expect(page).to have_title('New Item')
    expect(page).to have_content('Add your own image')
  end

  describe "Home page" do
    before { visit root_path }

    it { should have_content('Garden Exchange') }
    it { should_not have_title('| Home') }

    describe "Search function" do
      let!(:item) { FactoryGirl.create(:item) }
      let(:item2) { FactoryGirl.create(:item2, name: 'car',
                                       category_id: 2, email: 'car@car.com',
                                       description: 'car description' ) }
      let(:submit) { 'Search' }

      before do
        FactoryGirl.create_list(:category, 16)
        fill_in 'Where are you?', with: '1821 SE 35th Ave, Portland Or'
        fill_in 'How far do you want to look? (max 99 miles)', with: 2
        click_button submit
      end
        # it { should have_content('Curly Kale') }


    end
  end  

  describe "Search list page" do
    before { visit list_path }

    it { should have_content('Garden Exchange') }
    it { should have_title('Search List') }

    describe "Search function" do
      let(:item) { FactoryGirl.create(:item) }
      let(:submit) { 'Search' }
      before do
        FactoryGirl.create_list(:category, 16)
        fill_in 'Where are you?', with: '1821 SE 35th Ave, Portland Or'
        fill_in 'How far do you want to look? (max 99 miles)', with: 2
        click_button submit
      end
        # expect(page).to have_content('Curly Kale')
        specify{ expect(response).to redirect_to(list_path) }
    end
  end


end