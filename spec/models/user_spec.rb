require 'spec_helper'

require File.expand_path('../../../models/user.rb', __FILE__)

describe 'User' do
  it 'works' do
    u = User.new(name: 'test')
    expect { u.save! }.to change { User.count }.by(1)
  end

  describe 'presence' do
    it 'name' do
      expect(User.new).to_not be_valid
    end
  end

  describe 'uniqueness' do
    before do
      u = User.create!(name: 'John')
    end

    it 'name uniqueness' do
      expect(User.new(name: 'John').valid?).to eq(false)
    end
  end
end

