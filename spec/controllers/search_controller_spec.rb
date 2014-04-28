require 'spec_helper'

describe SearchController do
  describe "POST #search" do
    context "with valid attributes" do
      it "assigns a new search to @search" do
        search = @items
        get :index, @items
        assigns(:index).should eq(search)
      end
      it "populates an array of search parameters"
      it "renders the :index view"
    end
    context "with valid attributes" do
      it "assigns a new search to @search" do
        search = @items
        get :search_list, @items
        assigns(:search_list).should eq(search)
      end
      it "populates an array of search parameters"
      it "renders the :search_list view"
    end
  end
end
