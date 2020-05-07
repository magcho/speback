require 'rails_helper'


RSpec.describe User, type: :model do
  before do
    @user = build(:user)
  end
  
  describe 'validation' do

    it 'should be new successful'do
      expect(@user.valid?).to eq(true)
    end

    it 'should be blank name valid' do
      @user.name = ''
      expect(@user.valid?).to eq(false)
    end

    it 'should be blank twitter_uid valid' do
      @user.twitter_uid = ''
      expect(@user.valid?).to eq(false)
    end

    it 'should be blank twitter_id valid' do
      @user.twitter_id = ''
      expect(@user.valid?).to eq(false)
    end

    it 'should be blank icon_path valid' do
      @user.icon_path = ''
      expect(@user.valid?).to eq(false)
    end

    it 'should be lager icon_path valid' do
      @user.icon_path = 'a'*256
      expect(@user.valid?).to eq(false)
    end

  end
end

