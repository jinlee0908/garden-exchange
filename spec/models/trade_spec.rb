require 'spec_helper'

describe Trade do

  before :each do
    @trade = FactoryGirl.create(:trade)
  end

  subject { @trade }

  it { should respond_to(:name) }
  it { should respond_to(:trade_email) }
  it { should respond_to(:comment) }
  it { should respond_to(:phone_num) }

  it { should be_valid }

  describe 'when comment is not present' do
    before { @trade.comment = '' }
    it { should_not be_valid }
  end

  describe 'when email or text is not present' do
    before { @trade.trade_email = '' }
    before { @trade.phone_num = '' }
    it { should_not be_valid }
  end

  describe 'when email only is present' do
    before { @trade.trade_email = 'example@example.com' }
    before { @trade.phone_num = '' }
    it { should be_valid }
  end

  describe 'when phone only is present' do
    before { @trade.trade_email = '' }
    before { @trade.phone_num = '123-456-7890' }
    it { should be_valid }
  end

  describe 'when item id is not present' do
    before { @trade.item_id = nil }
    it { should_not be_valid }
  end

  describe 'when comment is too long' do
    before { @trade.comment = 'a' * 141 }
    it { should_not be_valid }
  end

  describe 'states' do
    describe ':new' do
      it 'should be an inital state' do
        @trade.should be_new
      end

      it 'should change to :pending on :request_made' do
        @trade.request_made!
        @trade.should be_pending
      end
    end

    describe ':pending' do
      it 'should change to :complete on :completed' do
        @trade.request_made!
        @trade.completed!
        @trade.should be_complete
      end

      it 'should change to :cancel on :cancel' do
        @trade.request_made!
        @trade.cancel!
        @trade.should be_cancel
      end
    end
  end
end
