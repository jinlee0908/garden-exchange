require 'spec_helper'

describe ItemsController do
  describe 'Item' do
    context 'with valid attributes' do
      it 'assigns a new search to @search' do
        item = @items
        get :new, @items
        assigns(:new).should eq(item)
      end
      it 'should return results' do
        get :new, 'item' => { 'location' => '1821 SE 35th Ave,
                                                Portland OR',
                              'miles' => '2',
                              'name' => 'kale',
                              'description' => 'kale2',
                              'email' => 'kal@test.com' }
        response.should be_ok
      end
    end
  end
end
