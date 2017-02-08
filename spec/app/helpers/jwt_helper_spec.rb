require 'spec_helper'

RSpec.describe "Heimdall::App::JWTHelper" do
  let(:helper){ Class.new }
  before { helper.extend Heimdall::App::JWTHelper }

  subject { helper }

  let(:brute_payload) do
    {
      "namespace" => {
        "freyr" => "freyja"
      }
    }
  end

  describe '#encode' do
    it 'returns a token' do
      expect(subject.encode(brute_payload)).to eq('eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJuYW1lc3BhY2UiOnsiZnJleXIiOiJmcmV5amEifX0.ENvdiUUyLGbWAw_jli804uSsQOpUyuq0RbMBiTCKKSo')
    end
  end

  describe '#decode' do
    it 'returns a payload' do
      expect(subject.decode('eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJuYW1lc3BhY2UiOnsiZnJleXIiOiJmcmV5amEifX0.ENvdiUUyLGbWAw_jli804uSsQOpUyuq0RbMBiTCKKSo')).to eq(brute_payload)
    end
  end
end
