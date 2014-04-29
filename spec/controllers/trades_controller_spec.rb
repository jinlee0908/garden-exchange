require 'spec_helper'

describe TradesController do
  before :each do
    @item = Item.create(id: 2,
                        description: 'This is an example.',
                        location: '123 First Street, Portland Oregon',
                        email: 'example@example.com',
                        phone: '123-456-7890',
                        state: 'active',
                        category_id: 12,
                        slug: 'blahblah')
    @params = { item_id: 2 }
  end

  describe 'GET new' do
    it 'assigns @trade' do
      @i = Item.find_by(id: @params[:item_id])
      trade = @i.trades.new
      get :new, item_id: 2, use_route: :new_item_trade
      expect(assigns(:trade)).to eq(trade)
    end

    it 'renders the create template' do
      get :new, item_id: 2, use_route: :new_item_trade
      expect(response).to render_template('new')
    end
  end
end
