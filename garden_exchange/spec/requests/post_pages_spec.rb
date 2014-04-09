require 'spec_helper'

describe "Post Pages" do

  subject { page }

  describe "post an item page" do
    it { should have_title('Garden Exchange | List an Item') }
  end
end
