require 'spec_helper'

describe Item do
  before do
    @item = Item.new(description: 'This is an example.',
                     location: '123 First Street, Portland Oregon',
                     email: 'example@example.com',
                     phone: '123-456-7890', state: 'active',
                     category_id: 12, slug: 'blahblah')
  end

  subject { @item }

  it { should respond_to(:description) }
  it { should respond_to(:location) }
  it { should respond_to(:email) }
  it { should respond_to(:phone) }
  it { should respond_to(:state) }
  it { should respond_to(:category_id) }

  it { should be_valid }

  describe 'when location is not present' do
    before { @item.location = '' }
    it { should_not be_valid }
  end

  describe 'when email or text is not present' do
    before { @item.email = '' }
    before { @item.phone = '' }
    it { should_not be_valid }
  end

  describe 'when email only is present' do
    before { @item.email = 'example@example.com' }
    before { @item.phone = '' }
    it { should be_valid }
  end

  describe 'when phone only is present' do
    before { @item.email = '' }
    before { @item.phone = '123-456-7890' }
    it { should be_valid }
  end

  describe 'when category id is not present' do
    before { @item.category_id = nil }
    it { should_not be_valid }
  end

  describe 'when description is too long' do
    before { @item.description = 'a' * 141 }
    it { should_not be_valid }
  end

  describe 'states' do
    describe ':active' do
      it 'should be an inital state' do
        @item.should be_active
      end

      it 'should change to :pending on :offer_made' do
        @item.offer_made!
        @item.should be_pending
      end

      it 'should change to :inactive on :cancel' do
        @item.cancel!
        @item.should be_inactive
      end
    end

    describe ':pending' do
      it 'should change to :complete on :completed' do
        @item.offer_made!
        @item.completed!
        @item.should be_complete
      end

      it 'should change to :active on :rejected' do
        @item.offer_made!
        @item.reject!
        @item.should be_active
      end
    end
  end
end
