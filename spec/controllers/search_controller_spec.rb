require 'spec_helper'

describe SearchController do
  describe "Search" do
    context "with valid attributes" do
      it "assigns a new search to @search" do
        search = @items
        get :index, @items
        assigns(:index).should eq(search)
      end
      it 'should return results' do
        get :index, "search" => { "location" => "1821 SE 35th Ave, Portland OR", "miles" => "2" }, "item" => {"category_id" => "2"}
        response.should be_ok
        # @items.map(&:name).should == ['expected1', 'expected2']
      end
    end
    context "with valid attributes" do
      it "assigns a new search to @search" do
        search = @items
        get :search_list, @items
        assigns(:search_list).should eq(search)
      end
      it 'should return results' do
        get :index, "search" => { "location" => "1821 SE 35th Ave, Portland OR", "miles" => "2" }, "item" => {"category_id" => "2"}
        response.should be_ok
        # @items.map(&:name).should == ['expected1', 'expected2']
      end
    end
  end
end

