require 'spec_helper'

RSpec.describe "Heimdall::App::RequestHelper" do
  let(:helper){ Class.new }
  before { helper.extend Heimdall::App::RequestHelper }

  subject { helper }

  describe '#payload' do
    let(:brute_payload) do
      {
        namespace: {
          "freyr" => "freyja"
        }
      }
    end

    let(:request_body) { Oj.dump(brute_payload) }
    let(:request) do
      OpenStruct.new(body: StringIO.new(request_body))
    end

    context 'when body' do
      before do
        allow(helper).to receive(:request).and_return(request)
        allow(helper).to receive(:params).and_return(nil)
      end

      it 'does parse json content to ruby' do
        expect(subject.payload(:namespace)).to eq( {"freyr" => "freyja"} )
      end
    end

    context 'when not body' do
      before do
        allow(helper).to receive(:params){ brute_payload }
      end

      it 'does parse json content to ruby' do
        expect(subject.payload(:namespace)).to eq( {"freyr" => "freyja"} )
      end
    end
  end
end
