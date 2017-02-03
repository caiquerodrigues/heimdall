require 'spec_helper'

RSpec.describe "Heimdall::App::ResponseHelper" do
  let(:helper){ Class.new }
  before { helper.extend Heimdall::App::ResponseHelper }

  subject { helper }

  describe '#render_response' do
    let(:render_message) { subject.render_message 'foo' }
    let(:message) { Oj.load(render_message)[:message] }

    it "returns a JSON string" do
      expect(render_message).to be_a_kind_of(String)
    end

    it "returns a message" do
      expect(message).to eq('foo')
    end
  end
end
